class ErrorsController < ApplicationController
  before_action :set_errors, only: [:show]

  def show
    respond_to do |format|
      format.json { render json: @errors}
    end
  end

  private
    # respond with errors from date=6/10/2015
    # OR by default respond with errors from today
    # TODO use errors table
    def set_errors
      @errors = {'errors' => [
            { "type" => "INTEGRATION",
              "timestamp" => "10/21/2015 08:00",
              "message" => "request for token XYZ timed out" },
          ]}
    end
end
