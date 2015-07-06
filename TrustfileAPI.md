# Trustfile API

### Orders
Endpoint can be accesssed by https://api.trustfile.avalara.com/v2/orders

#### POST /v2/orders?Company2TFToken=:Company2TFToken
- Orders are created or updated if they already exist.
- Send sale or refund
- include shipping costs/tax optionally
- Addresses are used to source the jurisdictions involved in the sale.  
- Defaults are used for Shipping or Origin Address if none provided or the address is invalid.
- Maximum of 1000 orders may be posted at one time.
- Orders must be posted in sequential order, otherwise the /orders/last will not be a reliable way to know what Trustfile knows about. 

```
        {
            "id": "/order",
            "type": "object",
            "required": [
                "orderId",
                "orderDate",
                "shippingState",
                "shippingZip",
                "shipping",
                "shippingTax"
            ],
            "properties":{
                "orderId": {
                    "type": "string"
                },
                "orderDate": {
                    "type": "string",
                    "format": "dateTime"
                },
                "shippingState": {
                    "type": "string"
                },
                "shippingZip": {
                    "type": "string"
                },
                "shipping": {
                    "type": "number"
                },
                "shippingTax": {
                    "type": "number"
                },
                "originStreet": {
                    "type": "string"
                },
                "originCity": {
                    "type": "string"
                },
                "originState": {
                    "type": "string"
                },
                "originZip": {
                    "type": "string"
                },
                "shippingStreet": {
                    "type": "string"
                },
                "shippingCity": {
                    "type": "string"
                },
                "sales": {
                    "type": "number"
                },
                "salesTax":{
                    "type": "number"
                },
                "quantity": {
                    "type": "integer"
                },
                "description": {
                    "type": "string"
                },
                "refund": {
                    "type": "boolean"
                }
            }
        }
```


### Create Basic Order
+ Request (application/json)
    
    + Body
    
            {
                "orders": [
                    {
                        "orderId": "3002987",
                        "orderDate": "2014-12-09T09:53:59",
                        "shippingStreet": "4077 West Clinton Avenue",
                        "shippingCity": "Fresno",
                        "shippingState": "CA",
                        "shippingZip": "93722",
                        "shipping": "30.00",
                        "shippingTax": "3.29",
                        "sales": "514.99",
                        "salesTax": "42.36",
                        "quantity": "1",
                        "description": "Feenn Ruby Brooch",
                        "refund": false
                    }
                ]
            }

+ Response 200 (application/json)

        { 
            "isAuthenticated": true,
            "success": true,
            "processed": 0,
            "dateTime": "2015-04-10T07:00:00.000Z"
        }

+ Response 200 (application/json)

        { 
            "isAuthenticated": true,
            "success": false,
            "message": "Too many orders. Max length 1000"
        }


+ Response 403 (application/json)
        
        { "isAuthenticated": false }

+ Response 500 (application/json)

        { "status": {"error": "service unavailable" }}


+ Request (application/json)
    
    + Body
    
            {
                "orders": [
                    {
                        "orderId": "3002987",
                        "orderDate": "2014-12-09T09:53:59",
                        "shippingStreet": "4077 West Clinton Avenue",
                        "shippingCity": "Fresno",
                        "shippingState": "CA",
                        "shippingZip": "93722",
                        "shipping": "30.00",
                        "shippingTax": "3.29",
                        "sales": "514.99",
                        "salesTax": "42.36",
                        "quantity": "1",
                        "description": "Feenn Ruby Brooch",
                        "refund": true
                    }
                ]
            }

+ Response 200 (application/json)

        { 
            "isAuthenticated": true,
            "success": true,
            "processed": 100,
            "dateTime": "2015-04-10T07:00:00.000Z"
        }

+ Response 200 (application/json)

        { 
            "isAuthenticated": true,
            "success": false,
            "message": "Too many orders. Max length 1000",
            "dateTime": "2015-04-10T07:00:00.000Z"
        }


+ Response 403 (application/json)
        
        { "isAuthenticated": false }

+ Response 500 (application/json)

        { "status": {"error": "service unavailable" }}


+ Request (application/json)
    
    + Body
     
            {
                "orders": [
                    {
                        "orderId": "3002987",
                        "orderDate": "2014-12-09T09:53:59",
                        "originStreet": "4077 West Clinton Avenue",
                        "originCity": "Fresno",
                        "originState": "CA",
                        "originZip": "93722",
                        "shippingStreet": "4077 West Clinton Avenue",
                        "shippingCity": "Fresno",
                        "shippingState": "CA",
                        "shippingZip": "93722",
                        "shipping": "30.00",
                        "shippingTax": "3.29",
                        "sales": "514.99",
                        "salesTax": "42.36",
                        "quantity": "1",
                        "description": "Feenn Ruby Brooch",
                        "refund": false
                    }
                ]
            }


+ Response 200 (application/json)

        { 
            "isAuthenticated": true,
            "success": false,
            "message": "Too many orders. Max length 1000",
            "dateTime": "2015-04-10T07:00:00.000Z"
        }
        
+ Response 200 (application/json)

        { 
            "success": false,
            "processed": 0,
            "dateTime": '2015-04-10T07:00:00.000Z',
            "errors":
            [   
                { 
                    "keyword": 'type',
                    "dataPath": '.orders[0].shippingTax',
                    "message": 'should be number',
                    "schema": 'number',
                    "data": '.00' 
                },
                { 
                    "keyword": 'format',
                    "dataPath": '.orders[1].orderDate',
                    "message": 'should match format dateTime',
                    "schema": 'dateTime',
                    "data": '2000-30-30' 
                } 
            ] 
        }


+ Response 403 (application/json)
        
        { "isAuthenticated": false }

+ Response 500 (application/json)

        { "status": {"error": "service unavailable" }}


### Alerts 

Endpoint can be accesssed by https://orders.trustfile.avalara.com/v2/orders

#### POST /v2/alerts

```
        {
          [        
             {"timestamp": "10/21/2015 08:00",  "type": 'DATASOURCE', "Company2TFToken": "1231211321", "alert": "unable to authenticate.  disabling."},
             {"timestamp": "10/21/2015 08:00",  "type": 'DATASOURCE', "Company2TFToken": "1231211321", "alert": "throttled.  retrying."}
          ]
        
        }
```

```
        {
          [        
             {"timestamp": "10/21/2015 08:00",  "type": 'INTEGRATION', "alert": "connection to http:// timing out.  Retrying"},
             {"timestamp": "10/21/2015 09:00",  "type": 'INTEGRATION', "alert": "connection to http:// timing out.  Retrying"},
             {"timestamp": "10/21/2015 10:00",  "type": 'INTEGRATION', "alert": "connection to http:// timing out."}
          ]
        
        }
```



### Signup
Endpoint can be accesssed by https://api.trustfile.avalara.com/v2/company/signup

#### POST /v2/company/signup

All data is expected in the request body in a flat JSON format.

Required Field:
    email

Optional User Fields:
    firstName
    lastName

Optional Company fields:
    companyName
    companyPhone
    companyLine1
    companyLine2
    companyLine3
    companyCity
    companyZip
    companyState
    companyCountry
    
Optional Lead fields:
    campaignId
    lsmr
    integratorId
    salesUserId
    salesUserEmail


example body
```
{
    "email": "ken.everett@avalara.com",
    "firstName": "Ken",
    "lastName": "Everett",
    "companyName": "Best Company Ever",
    "campaignId": 2 
}
```
