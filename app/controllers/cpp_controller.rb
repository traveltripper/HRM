class CppController < ApplicationController
  before_action :authenticate_employee!
  before_action :set_cpp, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  layout 'hrmdashboard'
  # GET /cpps
  # GET /cpps.json
  def index
    @cpps = Cpp.all
  end

  # GET /cpps/1
  # GET /cpps/1.json
  def show
  end

  # GET /cpps/new
  def new
    @cpp = Cpp.new
  end

  # GET /cpps/1/edit
  def edit
  end

  # POST /cpps
  # POST /cpps.json
  def create
    @cpp = Cpp.new(cpp_params)

    respond_to do |format|
      if @cpp.save
        format.html { redirect_to @cpp, notice: 'CPP was successfully created.' }
        format.json { render :show, status: :created, location: @cpp }
      else
        format.html { render :new }
        format.json { render json: @cpp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cpps/1
  # PATCH/PUT /cpps/1.json
  def update
    respond_to do |format|
      if @cpp.update(cpp_params)
        format.html { redirect_to @cpp, notice: 'CPP was successfully updated.' }
        format.json { render :show, status: :ok, location: @cpp }
      else
        format.html { render :edit }
        format.json { render json: @cpp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cpps/1
  # DELETE /cpps/1.json
  def destroy
    @cpp.destroy
    respond_to do |format|
      format.html { redirect_to cpp_index_path, notice: 'CPP was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cpp
      @cpp = Cpp.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cpp_params
      params.require(:cpp).permit(:description, :designation)
    end
end
