Rails.application.routes.draw do
  get 'connector', to: 'connectors#show', :defaults => { :format => 'json' }
  put 'connector', to: 'connectors#update', :defaults => { :format => 'json' }
  get 'connector/errors', to: 'errors#show', :defaults => { :format => 'json' }
  get 'orangez/health', to: 'health#show', :defaults => { :format => 'json' }
  get 'datasources', to: 'datasources#index', :defaults => { :format => 'json' }
  get 'datasources/:company_2_tf_token', to: 'datasources#show', :defaults => { :format => 'json' }
  get 'datasources/:company_2_tf_token/activities', to: 'datasources#activities', :defaults => { :format => 'json' }
  put 'datasources/:company_2_tf_token', to: 'datasources#update', :defaults => { :format => 'json' }
  post 'datasources', to: 'datasources#create', :defaults => { :format => 'json' }
  get 'datasources/:company_2_tf_token/authentication', to: 'datasources#authenticate', :defaults => { :format => 'json' }
  delete 'datasources/:company_2_tf_token', to: 'datasources#destroy', :defaults => { :format => 'json' }
end
