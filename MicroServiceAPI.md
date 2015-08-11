# Trustfile Connector Implementation

## Glossary
* connector_2_tf_token - identifies the connector and restricts access to environments / version of TF API the connector is certified for. (See below for Token usage in header)
* company_2_tf_token - identifies and authorizes access to the TF company to push data into.
* tf_2_connector_token - authorizes Trustfile to access operate the connector micro-service API

## Dates and Timestamps
* dates are in yyyy-mm-dd format
* timestamps are in the ISO format: 2015-07-06T22:26:28+00:00
* timestamps are in UTC +00:00 timezone

## Configs
Put localization configs (specific to a given environment) into environment variables.
Document the required variables in the README.md of the project.
https://devcenter.heroku.com/articles/config-vars

## API requests are authorized with header param
```
Authorization: Bearer tf_2_connector_token
```

## Micro-service API 

### GET /datasources?enabled=true
Sample Response:  list of :company_2_tf_token 

```
{	
	"datasources": ["akjsfakljasd"]
}
```


#### GET /datasources/:company_2_tf_token

Sample Response: 

```
{	
	"enabled": false, 
	"authorized": false,
	"host_system_identifier": "account 13222432",
	"start_date": "2015-07-06",
	"status_changed_at": "2015-07-06T22:26:28+00:00",
	"last_sync_at": "2015-07-06T22:26:28+00:00",
	"next_sync_at": "2015-07-06T22:26:28+00:00",
	"status_message": "Trustfile is no longer authorized to access this Paypal account.  The connector has been disabled.  Reauthorize to re-enable synching.",
	"label": "user account info"
}
```
* Enabled datasources will process data periodically if authorized
* Authorized datasources are authenticated with the host integration system (paypal, amazon..) and allowed to pull sales/tax data
* The status message should be sufficient for the user to understand what state the connection is in and if there are any actions required of them to proceed.
* The host_system_identifier will be displayed to the user (if not null) in TF to identify which host account was used for this connector. 

Errors look like:
```
500
{
  status: 'error',
  message: 'User not found.'
}
```

#### GET /datasources/:company_2_tf_token/activty?days=14&limit=1000

Sample Response: 
```
{	
	"activity": [
		{"timestamp": "2015-07-06T22:26:28+00:00", "action": "requested sales tax report for 6/2/2015"},
		{"timestamp": "2015-07-06T22:26:28+00:00", "action": "sent tax report for 6/2/2015 to Trustfile API"}
	]
	
}
```
* default 2 weeks history to pull.  Trustfile may request up to 1 year of activity logs.
* the activity logs should be sufficient to help the user understand what's going on synchronizing their account with Trustfile.


Errors look like:
```
500
{
  status: 'error',
  message: 'User not found.'
}
```

#### POST /datasources
```
{	
	"company_2_tf_token": "123abc", 
	"start_date": "2015-07-06"
}
```
* the company_2_tf_token is used to identify the DataSource in the micro-service API.  It's also used to authorize access to a company when posting data to Trustfile.
* the connector will synchronize all the Sales / Tax data starting from the start_date into Trustfile.
* then the connector will periodically synchronize this datasource on at least a daily basis. 

Success
```
{
    "success": true
}
```

Errors look like:
```
500
{
  "success": false,
  "message": 'User already exists.'
}
```

#### GET /datasources/:company_2_tf_token/authentication?redirect_uri=app.trustfile.avalara.com/datasource/:token

Response will be rendored in a popup iframe to handle oAuth or other authentication mechanism. 
After the authentication is complete, redirect to the provided redirect_uri

#### PUT /datasources/:company_2_tf_token
```
{
	"enabled": false,
}
```
This API allows Trustfile to:
* enabled: true/false
* update the Company2TFToken, if that token is refreshed for security reasons in TF
* if the start_date is changed, the connector will pull all data from that new time period into Trustfile.

Success
```
{
    "status": "success"
}
```

Errors look like:
```
500
{
  status: 'error',
  message: 'User not found.'
}
```

#### DELETE /datasources/:company_2_tf_token

Sample Response:
```
{
	"status": "success"
}
```

Errors look like:
```
500
{
  status: 'error',
  message: 'User not found.'
}
```

### /orangez/health
NOTE:  does not require Authentication header
Sample response:
```
{  "statuses":
	[
	  {"type": "connector", "status": "OK", "description": "nominal"},
	  {"type": "host_system", "status": "OK", "description": "nominal"},
	  {"type": "trustfile", "status": "OK", "description": "nominal"}
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

{"enabled":true,"user_count":0,"last_updated_at":"2015-07-06T22:26:28+00:00",
	"metrics":
	{"jobs_pending":0,"jobs_duration_min":100,"jobs_duration_max":3000,
	  "jobs_duration_avg":300,"hourly_synced_count":25,"daily_synced_count":100}}
```

#### PUT /connector

```
{
	"enabled": false,
}
```

This allows Trustfile to enable/disable a connector.   When a connector is disabled, it stops synchronizing data with Trustfile until it is re-enabled.

Success
```
{
    "status": "success"
}
```

Errors look like:
```
500
{
  status: 'error',
  message: 'attribute not found.'
}
```

####  GET /connector/errors?date=2015-06-10T22:26:28+00:00

Domains: DATASOURCE, INTEGRATION, SYSTEM, ORDER

```
 "errors": [error]
}

Error Objects:

{
	"type": "INTEGRATION", 
	"timestamp": "2015-07-06T22:26:28+00:00", 
	"message": "request for token XYZ timed out"
}

{
	"type": "DATASOURCE", 
	"timestamp": "2015-07-06T22:26:28+00:00", 
	"message": "request for token ABC was throttled, retrying in 2 hours"
}

{
	"type": "SYSTEM", 
	"timestamp": "2015-07-06T22:26:28+00:00", 
	"message": "% Memory Used met or exceeded 80%, increasing to 80% for 10 minutes at 02:30AM and continued until 06:20PM"
}

{
	"type": "ORDER", 
	"timestamp": "2015-07-06T22:26:28+00:00", 
	"Company2TFToken": :token
	"bad_orders":  [
		" 'orderId': '3002987',
                        'orderDate': '2014-12-09T09:53:59',
                        'originStreet': '4077 West Clinton Avenue',
                        'originCity': 'Fresno',
                        'originState': 'CA',
                        'originZip': '93722',
                        'shippingStreet': '4077 West Clinton Avenue',
                        'shippingCity': 'Fresno',
                        'shippingState': 'CA',
                        'shippingZip': '93722',
                        'shipping': '30.00',
                        'shippingTax': '3.29',
                        'sales': '514.99',
                        'salesTax': '42.36',
                        'quantity': '1',
                        'description': 'Feenn Ruby Brooch',
                        'refund': false" ]
	"friendly_message": "missing sales",
	"message": CASTEXCEPTION
}
```
Possible types are:
* SYSTEM - internal issues (out of memory, db issues..)
* INTEGRATION - paypal throttling, timeouts/retries
* DATASOURCE - not authorized
* ORDER
