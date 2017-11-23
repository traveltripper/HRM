class PayrollsController < ApplicationController
  before_action :authenticate_employee!
  load_and_authorize_resource
  layout 'dashboard'
  before_action :set_payroll, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Payrolls", :payrolls_path
  # GET /payrolls
  # GET /payrolls.json
  def index
    @emp = current_employee
    if ["Employee", "Manager"].include? @emp.role.name
      @payrolls = @emp.payrolls.paginate(:page => params[:page], :per_page => 10)
    elsif ["Finance", "HR", "Admin"].include? @emp.role.name
      @payrolls = Payroll.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def download_payslip
    @emp = current_employee
    @payroll = @emp.payrolls.where('extract(year from pay_date) = ? and extract(month from pay_date) = ?', Date.today.strftime("%Y"), params[:month]).first
    if @payroll
      send_file(@payroll.attachment.path, :type => 'application/pdf', :disposition => 'attachment', :url_based_filename => true)
    else
      redirect_to hrm_payroll_path, notice: 'No Payroll'
    end
  end

  # GET /payrolls/1
  # GET /payrolls/1.json
  def show
    add_breadcrumb "Payroll"
  end

  # GET /payrolls/new
  def new
    @payroll = Payroll.new
    add_breadcrumb "Add Payroll"
  end

  # GET /payrolls/1/edit
  def edit
  end

  # POST /payrolls
  # POST /payrolls.json
  def create
    @payroll = Payroll.new(payroll_params)

    respond_to do |format|
      if @payroll.save
        format.html { redirect_to @payroll, notice: 'Payroll was successfully created.' }
        format.json { render :show, status: :created, location: @payroll }
      else
        format.html { render :new }
        format.json { render json: @payroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payrolls/1
  # PATCH/PUT /payrolls/1.json
  def update
    respond_to do |format|
      if @payroll.update(payroll_params)
        format.html { redirect_to @payroll, notice: 'Payroll was successfully updated.' }
        format.json { render :show, status: :ok, location: @payroll }
      else
        format.html { render :edit }
        format.json { render json: @payroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payrolls/1
  # DELETE /payrolls/1.json
  def destroy
    @payroll.destroy
    respond_to do |format|
      format.html { redirect_to payrolls_url, notice: 'Payroll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payroll
      @payroll = Payroll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payroll_params
      params.require(:payroll).permit(:employee_id, :attachment, :pay_date)
    end
end
