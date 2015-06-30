# Trustfile Connector Implementation

## Glossary
* Connector2TFToken - identifies the connector and restricts access to environments / version of TF API the connector is certified for. (See below for Token usage in header)
* Company2TFToken - identifies and authorizes access to the TF company to push data into.
* TF2ConnectorToken - authorizes Trustfile to access operate the connector micro-service API

### TConnector2TFToken Authentication token usage
Header Param:
```
Authorization: Bearer <Connector2TFToken>
```
## Micro-service API 

//need to add access token doc

### /datasource

#### GET /datasource/:Company2TFToken

Sample Response: 

```
{	
	"enabled": false,
	"authorized": false,										
	"status_changed_at": "10/21/2015 08:00",
	"last_sync_at": "10/21/2015 08:00",
	"next_sync_at": "10/21/2015 08:00",
	"status_message": "Trustfile is no longer authorized to access this Paypal account.  The connector has been disabled.  Reauthorize to re-enable synching."
}
```
* Enabled datasources will process data periodically if authorized
* Authorized datasources are authenticated with the host integration system (paypal, amazon..) and allowed to pull sales/tax data
* The status message should be sufficient for the user to understand what state the connection is in and if there are any actions required of them to proceed.
* 

#### GET /datasource/:Company2TFToken/activty?days=14&limit=1000

Sample Response: 
```
{	
	"activity": [
		{"timestamp": "10/21/2015 08:00", "action": "requested sales tax report for 6/2/2015"},
		{"timestamp": "10/21/2015 09:00", "action": "sent tax report for 6/2/2015 to Trustfile API"}
	]
	
}
```
* default 2 weeks history to pull.  Trustfile may request up to 1 year of activity logs.
* the activity logs should be sufficient to help the user understand what's going on synchronizing their account with Trustfile.
* ??TBD Date formate ???

#### POST /datasource
```
{	
	"Company2TFToken": "123abc" 
	"start_date": "5/1/2015"
}
```
* the Company2TFToken is used to identify the DataSource in the micro-service API.  It's also used to authorize access to a company when posting data to Trustfile.
* the connector will synchronize all the Sales / Tax data starting from the start_date into Trustfile.
* then the connector will periodically synchronize this datasource on at least a daily basis. 

#### GET /datasource/:Company2TFToken/authentication
Sample querified:
```
{
	"redirect_uri": "app.trustfile.avalara.com/datasource/:token"	
}
```

This call returns an iframe to complete the authentication with the host system.  The iframe is rendered in the DataSource management view of Trustfile.


#### PUT /datasource/:Company2TFToken
```
{
	"enabled": false,
}
```
This API allows Trustfile to:
* enabled: true/false
* update the Company2TFToken, if that token is refreshed for security reasons in TF
* if the start_date is changed, the connector will pull all data from that new time period into Trustfile.

#### DELETE /datasource/:Company2TFToken

Sample Response:
```
{
	"status": "success"
}
```

### /orangez/health
Sample response:
```
{  "healthiness":
	[
	  {"connector": "OK", "description": ""},
	  {"host_system": "OK", "description": "responding normal"},
	  {"trustfile": "OK", "description": "responding normal"}
	]
}
```
We use this API to monitor the health and general availability of the connector.  
Possible statuses are:
* OK - nominal 
* FAIL - integration point is non-responsive or failing
* DEGRADED - functional, but not functioning at full capacity

### /connector

#### GET /connector

Sample response:
```
{
	"enabled": true,
	"metrics": {
		jobs_pending: 32
		job_duration {
			min: 100		//In seconds
			max: 3000
			average:1500
			
		}
		"hourly_count": 100
		"daily_count": 20
	}
	"user_count": 102,
	"last_updated": "5/1/2015",
}
```

#### PUT /connector

```
{
	"enabled": false,
}
```

This allows Trustfile to enable/disable a connector.   When a connector is disabled, it stops synchronizing data with Trustfile until it is re-enabled.

####  GET /connector/errors?date=6/10/2015

Domains: DATASOURCE, INTEGRATION, SYSTEM, ORDER

```
 "errors": [error]
}

Error Objects:

{
	"type": "INTEGRATION", 
	"timestamp": "10/21/2015 08:00", 
	"message": "request for token XYZ timed out"
}

{
	"type": "DATASOURCE", 
	"timestamp": "10/21/2015 09:00", 
	"message": "request for token ABC was throttled, retrying in 2 hours"
}

{
	"type": "SYSTEM", 
	"timestamp": "10/21/2015 09:00", 
	"message": "% Memory Used met or exceeded 80%, increasing to 80% for 10 minutes at 02:30AM and continued until 06:20PM"
}

{
	"type": "ORDER", 
	"timestamp": "10/21/2015 09:00", 
	"Company2TFToken": :token
	"bad_orders":  [
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
	"friendly_message": "missing sales",
	"message": CASTEXCEPTION
}
```
Possible types are:
* SYSTEM - internal issues (out of memory, db issues..)
* INTEGRATION - paypal throttling, timeouts/retries
* DATASOURCE - not authorized
* ORDER
