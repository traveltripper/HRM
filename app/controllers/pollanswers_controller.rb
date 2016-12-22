class PollanswersController < ApplicationController
  before_action :set_pollanswer, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'
  before_action :authenticate_employee!
  load_and_authorize_resource
  
  # GET /pollanswers
  # GET /pollanswers.json
  def index
    @pollanswers = Pollanswer.all
  end

  # GET /pollanswers/1
  # GET /pollanswers/1.json
  def show
  end

  # GET /pollanswers/new
  def new
    @pollanswer = Pollanswer.new
  end

  # GET /pollanswers/1/edit
  def edit
  end

  # POST /pollanswers
  # POST /pollanswers.json
  def create
    @pollanswer = Pollanswer.new(pollanswer_params)

    respond_to do |format|
      if @pollanswer.save
        format.html { redirect_to @pollanswer, notice: 'Pollanswer was successfully created.' }
        format.json { render :show, status: :created, location: @pollanswer }
      else
        format.html { render :new }
        format.json { render json: @pollanswer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pollanswers/1
  # PATCH/PUT /pollanswers/1.json
  def update
    respond_to do |format|
      if @pollanswer.update(pollanswer_params)
        format.html { redirect_to @pollanswer, notice: 'Pollanswer was successfully updated.' }
        format.json { render :show, status: :ok, location: @pollanswer }
      else
        format.html { render :edit }
        format.json { render json: @pollanswer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pollanswers/1
  # DELETE /pollanswers/1.json
  def destroy
    @pollanswer.destroy
    respond_to do |format|
      format.html { redirect_to pollanswers_url, notice: 'Pollanswer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pollanswer
      @pollanswer = Pollanswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pollanswer_params
      params.require(:pollanswer).permit(:pollquestion_id, :option, :status)
    end
end
