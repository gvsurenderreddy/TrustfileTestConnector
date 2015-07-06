# test connector faked data
Connector.create(name: 'Fake Connector',enabled: true, user_count: 0, :jobs_pending => 0, :jobs_duration_min => 100, :jobs_duration_max => 3000, :jobs_duration_avg => 300, :hourly_synced_count => 25)
Error.create(:error_type => 'INTEGRATION', :error_timestamp => DateTime.now, :message => "request for token XYZ timed out")
Error.create(:error_type => 'DATASOURCE', :error_timestamp => DateTime.now, :message => "request for token ABC was throttled, retrying in 2 hours")
Error.create(:error_type => 'SYSTEM', :error_timestamp => DateTime.now, :message => "% Memory Used met or exceeded 80%, increasing to 80% for 10 minutes at 02:30AM and continued until 06:20PM")

bad_orders = [
       {
           "orderId" => "3002987",
           "orderDate" => "2014-12-09T09:53:59",
           "originStreet" => "4077 West Clinton Avenue",
           "originCity" => "Fresno",
           "originState" => "CA",
           "originZip" =>  "93722",
           "shippingStreet" => "4077 West Clinton Avenue",
           "shippingCity" => "Fresno",
           "shippingState" => "CA",
           "shippingZip" => "93722",
           "shipping" => "30.00",
           "shippingTax" => "3.29",
           "sales" => "514.99",
           "salesTax" => "42.36",
           "quantity" => "1",
           "description" => "Feenn Ruby Brooch",
           "refund" => false
       }
   ]

Error.create(:error_type => 'ORDER', :error_timestamp => DateTime.now, :message => "CASTEXCEPTION", :company_2_tf_token => '12123121lk123', :friendly_message => 'missing sales', :bad_orders => bad_orders)
ds = Datasource.create(:enabled => true, :authorized => true, :company_name => 'company co', :email => 'user@email.com', :start_date => DateTime.now, :company_2_tf_token => '123kl123')
ds.activities << Activity.create(:action => "requested sales tax report for 6/2/2015")
ds.activities << Activity.create(:action => "sent tax report for 6/2/2015 to Trustfile API")
