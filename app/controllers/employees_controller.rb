class EmployeesController < ApplicationController
  before_action :authenticate_employee!
  layout 'dashboard'
  add_breadcrumb "Home", :root_path
  def index
  	@employee = current_employee
    @employees = Employee.all
  end

  def show
    @employee = Employee.find_by_id(params[:id])
    render :template => 'employees/profile'
  end

  def new
    @employee = Employee.new
    add_breadcrumb "New Employee", new_employee_path
  end

  def edit
    @employee = Employee.find_by_id(params[:id])
  end

  def create
    @employee = Employee.new(employee_params)
    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @employee = Employee.find_by_id(params[:id])
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def dashboard
    add_breadcrumb "Dashboard", dashboard_path
  end

  def reports
    add_breadcrumb "Reports", reports_path
  end

  def profile
    @employee = current_employee
    add_breadcrumb "Profile", profile_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:first_name, :middle_name, :last_name, :manager_id, :role_id, :department_id, :ttid, :email, :personal_email, :contact_no, :emergency_name, :emergency_contact_no, :actual_dob, :certificate_dob, :doj, :prev_years_of_exp, :pg, :graduation, :source_of_hire, :pancard_no, :passport_no, :status, :lwd, :date_of_resignation, :address, :password, :password_confirmation )
    end
end