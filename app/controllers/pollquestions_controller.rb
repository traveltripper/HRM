class PollquestionsController < ApplicationController
  before_action :set_pollquestion, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'
  before_action :authenticate_employee!
  load_and_authorize_resource  
  include PollsHelper
  # GET /pollquestions
  # GET /pollquestions.json
  def index
    @pollquestions = Pollquestion.all
  end

  # GET /pollquestions/1
  # GET /pollquestions/1.json
  def show
    @answers = @pollquestion.pollanswers
  end

  # GET /pollquestions/new
  def new
    @pollquestion = Pollquestion.new
     #1.times { @pollquestion.pollanswers.build }
  end

  # GET /pollquestions/1/edit
  def edit
  end

  # POST /pollquestions
  # POST /pollquestions.json
  def create
    @pollquestion = Pollquestion.new(pollquestion_params)

    respond_to do |format|
      if @pollquestion.save
        format.html { redirect_to @pollquestion, notice: 'Pollquestion was successfully created.' }
        format.json { render :show, status: :created, location: @pollquestion }
      else
        format.html { render :new }
        format.json { render json: @pollquestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pollquestions/1
  # PATCH/PUT /pollquestions/1.json
  def update
    respond_to do |format|
      if @pollquestion.update(pollquestion_params)
        format.html { redirect_to @pollquestion, notice: 'Pollquestion was successfully updated.' }
        format.json { render :show, status: :ok, location: @pollquestion }
      else
        format.html { render :edit }
        format.json { render json: @pollquestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pollquestions/1
  # DELETE /pollquestions/1.json
  def destroy
    @pollquestion.destroy
    respond_to do |format|
      format.html { redirect_to pollquestions_url, notice: 'Pollquestion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def poll
    @pollquestion = Pollquestion.find(params[:id])
    @poll = Poll.new
  end

  def savepoll
    #@pollquestion = Pollquestion.find(params[:id])
    #redirect_to poll_pollquestion_path(pollquestion)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pollquestion
      @pollquestion = Pollquestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pollquestion_params
      params.require(:pollquestion).permit(:question, :status, pollanswers_attributes: [:id, :option, :_destroy])
    end
end
