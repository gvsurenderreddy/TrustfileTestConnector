Rails.application.routes.draw do
  get 'connector', to: 'connectors#show', :defaults => { :format => 'json' }
  put 'connector', to: 'connectors#update', :defaults => { :format => 'json' }
  get 'connector/errors', to: 'errors#show', :defaults => { :format => 'json' }
  get 'orangez/health', to: 'health#show', :defaults => { :format => 'json' }
  get 'datasources/:company_2_tf_token', to: 'connectors#show', :defaults => { :format => 'json' }
  get 'datasources/:company_2_tf_token/activity', to: 'connectors#activity', :defaults => { :format => 'json' }
  put 'datasources/:company_2_tf_token', to: 'connectors#update', :defaults => { :format => 'json' }
  post 'datasources/:company_2_tf_token', to: 'connectors#create', :defaults => { :format => 'json' }
  get 'datasources/:company_2_tf_token/authentication', to: 'connectors#authenticate', :defaults => { :format => 'json' }
  delete 'datasources/:company_2_tf_token', to: 'connectors#destroy', :defaults => { :format => 'json' }
end
