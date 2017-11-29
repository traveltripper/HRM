class NominationsController < ApplicationController
  before_action :set_nomination, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_employee!  
  layout 'hrmdashboard'
  #load_and_authorize_resource
  

  # GET /nominations
  # GET /nominations.json
  def index
    if current_employee.role.name == "Admin"
      @nominations = Nomination.all
    else
      redirect_to root_path
    end
  end

  # GET /nominations/1
  # GET /nominations/1.json
  def show
  end

  # GET /nominations/new
  def new
    @nomination = Nomination.new
  end

  # GET /nominations/1/edit
  def edit
  end

  # POST /nominations
  # POST /nominations.json
  def create
    @nomination = Nomination.new(nomination_params)

    respond_to do |format|
      if @nomination.save
        format.html { redirect_to root_path, notice: 'Thanks for your interest on sugesting the name for HRM tool. Will get back to you with results very soon.' }
        format.json { render :show, status: :created, location: @nomination }
      else
        format.html { render :new }
        format.json { render json: @nomination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nominations/1
  # PATCH/PUT /nominations/1.json
  def update
    respond_to do |format|
      if @nomination.update(nomination_params)
        format.html { redirect_to @nomination, notice: 'Nomination was successfully updated.' }
        format.json { render :show, status: :ok, location: @nomination }
      else
        format.html { render :edit }
        format.json { render json: @nomination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nominations/1
  # DELETE /nominations/1.json
  def destroy
    @nomination.destroy
    respond_to do |format|
      format.html { redirect_to nominations_url, notice: 'Nomination was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nomination
      @nomination = Nomination.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nomination_params
      params.require(:nomination).permit(:type, :name, :employee_id)
    end
end
