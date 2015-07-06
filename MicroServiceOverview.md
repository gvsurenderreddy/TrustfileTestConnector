A Connector micro-service is a way to allow all custom integration / ETL to behave/operate in the exact same way.

### Connector Micro-service responsibility

```
 - integrating with TF Orders API 
 - integrating with host system API.. including authorization (typically something like oAuth)
 - ETL of sales/refunds/tax/shipping data into Trustfile data model
 - basic management of user data sources:  CRUD, enable/disable/status
 - scheduling and load balancing of users data synchronization
 - data integrity.  It is the responsibility of the connector micro-service to know what data has been processed by Trustfile.   There are no APIs to view what data Trustfile knows of per user.

Connector Micro-service is not responsible for:
 - User experience, branding of experience
 
See [Micro-Service API definition](https://github.com/Avalara/TrustfilePaypalConnector/blob/master/MicroServiceAPI.md)

  ```

### Hosting / Language
All connectors will be hosted and operated from the Heroku PaaS
* Language: choose between - Ruby/Node/Java
* DB: Postgres (on heroku)

### Normal sequence flow
#### Provisioning
| TF  | iframe | Connector | Host System |
| ------------- | ------------- | ------------- | ------------- |
| create datasource | | POST /datasources |  |
| authorize datasource | | GET /datasource/:token/authentication /datasources |  |
|  | user completes iframe |  | auth users account |
|  | redirect back to TF datasource view |  |  |
|  | sync sales/tax from start date |  |  |
|  | sync sales/tax on daily basis |  |  |


#### user viewing status in TF
| TF  |  Connector | Host System |
| ------------- | ------------- | ------------- | ------------- |
| view datasource | GET /datasources/:token |  |

#### user reauthenticating connector 
| TF  | iframe | Connector | Host System |
| ------------- | ------------- | ------------- | ------------- |
| clicks re-auth | | GET /datasource/:token/authentication /datasources |  |
|  | user completes iframe |  | auth users account |
|  | redirect back to TF datasource view |  |  |



### Event / Action scenarios
#### User
| Event  | Action |
| ------------- | ------------- |
| Throttled by host system (paypal) | alert TF.  end user can stop other services hitting the host system API.  |
| De-authorized by host system (paypal)  | alert TF.  user re-authenticates the data source   |
| invalid orders / junk data  | view errors in TF.  user manually adjusts return to compensate   |
| using wrong host account credential  | disable connector. create new connector   |

#### OPS
| Event  | Action |
| ------------- | ------------- |
|  host system down/degraded(paypal) | alert TF.  wait.  disable connector, re-enable when host system is backup.  |
| connector down  | escalate to connector devops   |
| slow performance / jobs backing up  | connector devops troubleshoots - tuning / adding capacity   |
| invalid Connector2TFToken token  | disable connector   |
| TF timeout  | retry connections for 1 hour.  disable connector   |

#### Integrator
| Event  | Action |
| ------------- | ------------- |
|  invalid order syntax /  missing required field | log. alert TF.  continuing processing that datasource, skipping bad data. fix connector and resend missing data.  |
|  invalid order attribute data type (floats, dates..) | log. alert TF.  continuing processing that datasource, skipping bad data.  fix connector and resend missing data.  |
