class HealthController < ApplicationController
  before_action :set_health, only: [:show]

  # respond with health of this connetor, host system and trustfile service from this connectors perspective
  def show
    respond_to do |format|
      format.json { render json: @health }
    end
  end

  private
    # either check responsiveness of connections real-time for this request or
    # store health from last request and display here
    def set_health
      @health = {'healthiness' => [
          {'connector' => 'OK', 'description' => 'nominal'},
          {'host_system' => 'OK', 'description' => 'nominal'},
          {'trustfile' => 'OK', 'description' => 'nominal'}
          ]}
    end
end
