# Trustfile API

### Orders
Endpoint can be accesssed by https://api.trustfile.avalara.com/v2/orders

#### POST /v2/orders
- Orders are created or updated if they already exist.
- Send sale or refund
- Addresses are used to source the jurisdictions involved in the sale.  
- Defaults are used for Origin Address if none provided or the address is invalid.
- Maximum of 1000 orders may be posted at one time.
- Orders must be posted in sequential order, otherwise the /orders/last will not be a reliable way to know what Trustfile knows about. 
- Required fields include: orderId, orderDate, shippingState, shippingZip, shippingTax, shipping, salesTax, quantity, refund.
- Optional fields:  originStreet, originCity, originState, originZip


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
                "connector_2_tf_token": "6d20c261-4e7d-4699-ac30-b206ebaa3377",
                "access_token":  "ae63d912-f8f9-46b6-936d-142131d09676",
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
                        "sales": 514.99,
                        "salesTax": 42.36,
                        "quantity": 1,
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
                "connector_2_tf_token": "6d20c261-4e7d-4699-ac30-b206ebaa3377",
                "access_token":  "ae63d912-f8f9-46b6-936d-142131d09676",
                "orders": [
                    {
                        "orderId": "3002987",
                        "orderDate": "2014-12-09T09:53:59",
                        "updateDate": "2014-12-09T09:53:59",
                        "shippingStreet": "4077 West Clinton Avenue",
                        "shippingCity": "Fresno",
                        "shippingState": "CA",
                        "shippingZip": "93722",
                        "shipping": "30.00",
                        "shippingTax": "3.29",
                        "sales": 514.99,
                        "salesTax": 42.36,
                        "quantity": 1,
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
                "connector_2_tf_token": "6d20c261-4e7d-4699-ac30-b206ebaa3377",
                "access_token":  "ae63d912-f8f9-46b6-936d-142131d09676",
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
                        "sales": 514.99,
                        "salesTax": 42.36,
                        "quantity": 1,
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

Endpoint can be accesssed by https://orders.trustfile.avalara.com/v2/alerts

#### POST /v2/alerts

```
        {
          "connector_2_tf_token": "6d20c261-4e7d-4699-ac30-b206ebaa3377",
          "alerts": [        
             {"timestamp": "10/21/2015 08:00",  "type": 'DATASOURCE', "company_2_tf_token": "1231211321", "alert": "unable to authenticate.  disabling."},
             {"timestamp": "10/21/2015 08:00",  "type": 'DATASOURCE', "company_2_tf_token": "1231211321", "alert": "throttled.  retrying."}
          ]
        
        }
```

```
        {
          "connector_2_tf_token": "6d20c261-4e7d-4699-ac30-b206ebaa3377",
          "alerts": [        
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
POST /v2/company/signup HTTP/1.1
Content-Type: application/json
Host: staging-api.trustfile.avalara.com
Connection: close
User-Agent: Paw/2.1.1 (Macintosh; OS X/10.10.5) GCDHTTPRequest
Content-Length: 301

{
  "email": "test.me@gmail.com",
  "firstName": "test",
  "lastName": "me",
  "companyPhone": "4258776015",
  "companyName": "Best Company Ever",
  "companyLine1": "street address",
  "companyCity": "city",
  "companyZip": "valid zip", 
  "companyState": "WA",
  "campaignId": "2"
}

```
example successful response
```
{"status":"Success","user":{"displayName":"Test Me","id":299,"first_name":"Test","last_name":"Me","email":"test.me@gmail.com","password":"$2a$10$n9fX961STOuCIBKBIM7ru.kVzijbjVBpWotnVdPmn9g4RpYTOcrjm","token":"b5159ea8-0d9d-4d65-8649-598692743fd6","account_setup":false,"tf_admin":false,"last_login_at":"2015-09-10T17:45:05.000Z","account_created":null,"company_id":"360","tos":false,"createdAt":"2015-09-10T17:45:05.550Z","updatedAt":"2015-09-10T17:45:05.550Z","company":{"id":360,"name":"Best Company Ever2","is_fba":null,"sync_date":"2015-09-10T17:45:05.447Z","fein":null,"phone":"4258776015","fax":null,"createdAt":"2015-09-10T17:45:05.457Z","updatedAt":"2015-09-10T17:45:05.457Z"}},"notification":{"message":"Account Created.","options":{"level":"success"}}}
```

example failure response
```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Sep 2015 17:47:29 GMT
ETag: W/"bd-fc030302"
X-Powered-By: Express
Content-Length: 189
Connection: Close

{"status":"Failed","user":null,"notification":{"message":"There was a problem creating your account. Error: An account with this email address exists already.","options":{"level":"error"}}
```


