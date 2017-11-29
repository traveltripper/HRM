class HealthinsurancesController < ApplicationController
  before_action :set_healthinsurance, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_employee!
  load_and_authorize_resource
  layout 'dashboard'
  # GET /healthinsurances
  # GET /healthinsurances.json
  def index
    @healthinsurances = Healthinsurance.all
  end

  # GET /healthinsurances/1
  # GET /healthinsurances/1.json
  def show
  end

  # GET /healthinsurances/new
  def new
    @healthinsurance = Healthinsurance.new
  end

  # GET /healthinsurances/1/edit
  def edit
  end

  # POST /healthinsurances
  # POST /healthinsurances.json
  def create
    @healthinsurance = Healthinsurance.new(healthinsurance_params)

    respond_to do |format|
      if @healthinsurance.save
        format.html { redirect_to @healthinsurance, notice: 'Healthinsurance was successfully created.' }
        format.json { render :show, status: :created, location: @healthinsurance }
      else
        format.html { render :new }
        format.json { render json: @healthinsurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /healthinsurances/1
  # PATCH/PUT /healthinsurances/1.json
  def update
    respond_to do |format|
      if @healthinsurance.update(healthinsurance_params)
        format.html { redirect_to @healthinsurance, notice: 'Healthinsurance was successfully updated.' }
        format.json { render :show, status: :ok, location: @healthinsurance }
      else
        format.html { render :edit }
        format.json { render json: @healthinsurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /healthinsurances/1
  # DELETE /healthinsurances/1.json
  def destroy
    @healthinsurance.destroy
    respond_to do |format|
      format.html { redirect_to healthinsurances_url, notice: 'Healthinsurance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_healthinsurance
      @healthinsurance = Healthinsurance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def healthinsurance_params
      params.require(:healthinsurance).permit(:name, :card_number, :relation, :issued_date, :policy_start_date, :policy_end_date, :employee_id)
    end
end
