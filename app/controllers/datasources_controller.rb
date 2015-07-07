class DatasourcesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create, :update, :destroy]
  before_action :set_datasource, only: [:show, :activities, :update, :destroy]

  # GET /datasources
  def index
    @datasources = Datasource.all
    respond_to do |format|
      format.json { render json: {:datasources => @datasources} }
    end
  end

  # GET /datasources/:company_2_tf_token/activities
  # TODO default 2 weeks history to pull. Trustfile may request up to 1 year of activity logs.
  # TODO parameters days=14&limit=1000
  def activities
    respond_to do |format|
      format.json { render json: {:activities => @datasource.activities} }
    end
  end

  # GET /datasources/:company_2_tf_token
  def show
    respond_to do |format|
      format.json { render json: {:datasource => @datasource} }
    end
  end

  # POST /datasources
  def create
    set_unique # TODO - clean up, this isn't necessary
    @datasource = Datasource.new(datasource_params)

    respond_to do |format|
      if @unique && @datasource.save
        format.json { render json: {:datasource => @datasource} }
      elsif !@unique
        format.json { render json: {"error" => "datasource not unique"}, status: :unprocessable_entity }
      else
        format.json { render json: @datasource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /datasources/:company_2_tf_token
  # TODO resync historical data if start_date changed
  # TODO stop syncing if disabled
  def update
    set_unique # TODO - clean up, this isn't necessary
    respond_to do |format|
      if @datasource == nil
        format.json { render json: {"error" => "not found"}, status: :unprocessable_entity }
      elsif !@unique
        format.json { render json: {"error" => "datasource not unique"}, status: :unprocessable_entity }
      elsif @datasource.update(datasource_params)
        format.json { render json: {:datasource => @datasource} }
      else
        format.json { render json: @datasource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datasources/:company_2_tf_token
  def destroy
    @datasource.destroy if @datasource
    respond_to do |format|
      format.json { head :no_content } if @datasource
      format.json { render json: {"error" => "datasource not found"}, status: :unprocessable_entity } unless @datasource
    end
  end

  def authenticate
    respond_to do |format|
        format.json { render json: @datasource.errors, status: :unprocessable_entity }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datasource
      @datasource = Datasource.where(:company_2_tf_token => params[:company_2_tf_token]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datasource_params
      params.require(:datasource).permit(:enabled, :start_date, :company_2_tf_token)
    end

    def set_unique
      @unique = true
      @unique = false if Datasource.where(:company_2_tf_token => datasource_params['company_2_tf_token']).size != 0
    end

end
