class AuthenticatedController < ApplicationController
  before_action :authorize_api_request

  private
    # just a simple check for 'Authorization  Bearer :tf_2_connector_token' in the header
    def authorize_api_request
      @authenticated_api_request = request.headers['Authorization'] == 'Bearer a1e7e99a-1ec3-4fdd-b4d6-c2d635653198'
      # TODO read tf_2_connector_token from config
      # TODO fail API gracefully if not authenticated
    end
end
