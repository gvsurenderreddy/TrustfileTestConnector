class ConnectorsController < ApplicationController
  before_action :set_connector, only: [:show, :update]

  # GET /connectors/1
  # GET /connectors/1.json
  def show
    respond_to do |format|
      format.json { render json: @show }
    end
  end

  # PATCH/PUT /connectors/1
  # PATCH/PUT /connectors/1.json
  def update
    respond_to do |format|
      if @connector.update(connector_params)
        format.html { redirect_to @connector, notice: 'Connector was successfully updated.' }
        format.json { render :show, status: :ok, location: @connector }
      else
        format.html { render :edit }
        format.json { render json: @connector.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_connector
      @connector = Connector.first

      @show = {:enabled => @connector.enabled,
               :user_count => @connector.user_count,
               :last_updated_at => @connector.last_updated_at,
               :metrics => {
                 :jobs_pending => @connector.jobs_pending,
                 :jobs_duration_min => @connector.jobs_duration_min,
                 :jobs_duration_max => @connector.jobs_duration_max,
                 :jobs_duration_avg => @connector.jobs_duration_avg,
                 :hourly_synced_count => @connector.hourly_synced_count,
                 :daily_synced_count => @connector.daily_synced_count
                 }}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def connector_params
      params.require(:connector).permit(:enabled, :user_count, :last_updated_at)
    end
end
