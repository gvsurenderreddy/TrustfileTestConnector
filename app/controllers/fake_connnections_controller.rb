class FakeConnnectionsController < ApplicationController
  before_action :set_fake_connnection, only: [:show, :edit, :update, :destroy]

  # GET /fake_connnections
  # GET /fake_connnections.json
  def index
    @fake_connnections = FakeConnnection.all
  end

  # GET /fake_connnections/1
  # GET /fake_connnections/1.json
  def show
  end

  # GET /fake_connnections/new
  def new
    @company_2_tf_token = params[:company_2_tf_token]
    @datasource = Datasource.where(:company_2_tf_token => @company_2_tf_token).first
    @datasource.redirect = params[:redirect_uri]
    @datasource.save

    @fake_connnection = FakeConnnection.new
  end

  # GET /fake_connnections/1/edit
  def edit
  end

  # POST /fake_connnections
  # POST /fake_connnections.json
  def create
    @fake_connnection = FakeConnnection.new(fake_connnection_params)

    respond_to do |format|
      if @fake_connnection.save
        format.html { redirect_to @fake_connnection, notice: 'Fake connnection was successfully created.' }
        format.json { render :show, status: :created, location: @fake_connnection }
      else
        format.html { render :new }
        format.json { render json: @fake_connnection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fake_connnections/1
  # PATCH/PUT /fake_connnections/1.json
  def update
    respond_to do |format|
      if @fake_connnection.update(fake_connnection_params)
        format.html { redirect_to @fake_connnection, notice: 'Fake connnection was successfully updated.' }
        format.json { render :show, status: :ok, location: @fake_connnection }
      else
        format.html { render :edit }
        format.json { render json: @fake_connnection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fake_connnections/1
  # DELETE /fake_connnections/1.json
  def destroy
    @fake_connnection.destroy
    respond_to do |format|
      format.html { redirect_to fake_connnections_url, notice: 'Fake connnection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fake_connnection
      @fake_connnection = FakeConnnection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fake_connnection_params
      params.require(:fake_connnection).permit(:name, :state, :sale_count, :refund_count, :scenario)
    end

end
