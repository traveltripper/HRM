class LeavetypesController < ApplicationController
  before_action :authenticate_employee!
  load_and_authorize_resource
  layout 'dashboard'
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Leavetypes", :leavetypes_path
  before_action :set_leavetype, only: [:show, :edit, :update, :destroy]

  # GET /leavetypes
  # GET /leavetypes.json
  def index
    @leavetypes = Leavetype.all
  end

  # GET /leavetypes/1
  # GET /leavetypes/1.json
  def show
    add_breadcrumb "Leavetype"
  end

  # GET /leavetypes/new
  def new
    @leavetype = Leavetype.new
    add_breadcrumb "Add Leavetype"
  end

  # GET /leavetypes/1/edit
  def edit
    add_breadcrumb "Edit Leavetype"
  end

  # POST /leavetypes
  # POST /leavetypes.json
  def create
    @leavetype = Leavetype.new(leavetype_params)

    respond_to do |format|
      if @leavetype.save
        format.html { redirect_to @leavetype, notice: 'Leavetype was successfully created.' }
        format.json { render :show, status: :created, location: @leavetype }
      else
        format.html { render :new }
        format.json { render json: @leavetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leavetypes/1
  # PATCH/PUT /leavetypes/1.json
  def update
    respond_to do |format|
      if @leavetype.update(leavetype_params)
        format.html { redirect_to @leavetype, notice: 'Leavetype was successfully updated.' }
        format.json { render :show, status: :ok, location: @leavetype }
      else
        format.html { render :edit }
        format.json { render json: @leavetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leavetypes/1
  # DELETE /leavetypes/1.json
  def destroy
    @leavetype.destroy
    respond_to do |format|
      format.html { redirect_to leavetypes_url, notice: 'Leavetype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leavetype
      @leavetype = Leavetype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leavetype_params
      params.require(:leavetype).permit(:name)
    end
end
