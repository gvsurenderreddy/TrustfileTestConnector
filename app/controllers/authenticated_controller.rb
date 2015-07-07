class AuthenticatedController < ApplicationController
  before_action :authorize_api_request

  private
    # just a simple check for 'Authorization  Bearer :tf_2_connector_token' in the header
    def authorize_api_request
      puts ""
      @authenticated_api_request = request.headers['Authorization'] == "Bearer #{ENV['TF_2_CONNECTOR_TOKEN']}"
      if !@authenticated_api_request
        respond_to do |format|
            format.json { render json: {:error => 'not authenticated'}, :status => :unauthorized}
        end
      end
    end
end
