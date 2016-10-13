class EmployeesController < ApplicationController
  before_action :authenticate_employee!
  #before_filter(:only => [:index, :show]) { unauthorized! if cannot? :read, :Employee }
  before_filter :require_permission, :only => [:index, :new, :create, :destroy]
  layout 'dashboard'
  add_breadcrumb "Home", :root_path
  respond_to :json
  def index
  	@employee = current_employee
    @employees = Employee.all
    add_breadcrumb "Employee Manager", :employees_path
  end

  def search
    @employees = Employee.all
    if params[:search]
      first_name =  params[:search]
      p @employees = Employee.where("first_name LIKE ?", "%#{first_name}%")
    else
      @employees = Employee.order('created_at DESC')
    end 
  end

  def show
    @employee = Employee.find_by_id(params[:id])
    add_breadcrumb "Employee Profile"
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


  def reports
    add_breadcrumb "Reports", reports_path
  end

  def profile
    @employee = current_employee
    add_breadcrumb "Profile", profile_path
  end

  def edit_profile
    @employee = current_employee    
    add_breadcrumb "Edit Profile"
  end

  def update_profile
    @employee = current_employee
    respond_to do |format|
      if @employee.update(profile_params)
        format.html { redirect_to profile_path, :notice => "Your profile has updated successfully"}
      else
        format.html { redirect_to edit_profile_path }
      end
    end
  end

  def require_permission
  if current_employee.role.name != "HR" 
    redirect_to dashboard_path
  end
  end    
  
  def team
    #@emp = current_employee
    @team = Employee.where(:department_id=> current_employee.department_id)
    # if current_employee.role.name == "Manager"
    # @team = @emp.subordinates
    # else
    # @team = @emp.manager.subordinates      
    # end
    add_breadcrumb "Team", team_path

  end

  def birthdays   
  
    @employees = Employee.all
    p startmonth = params[:start]
    p endmonth =  params[:end]
    
    #render json: @events.to_json
    # render :text => events.to_json    
    add_breadcrumb "Employees Birthday Calendar", :birthdays_path
  end

  def get_current_employee_role
    render json: {role: current_employee.role.name}
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:employee).permit( :current_address, :marital_status, :contact_no, :emergency_contact_no, :emergency_name )
    end

    def employee_params
      params.require(:employee).permit(:first_name, :middle_name, :last_name, :manager_id, :role_id, :department_id, :ttid, :email, :personal_email, :contact_no, :emergency_name, :emergency_contact_no, :actual_dob, :certificate_dob, :doj, :previous_employer, :prev_years_of_exp, :pg, :graduation, :source_of_hire, :pancard_no, :passport_no, :status, :lwd, :date_of_resignation, :address, :password, :password_confirmation, :blood_group, :father_or_spouse, :marital_status, :graduation_institution, :graduation_university, :pg_university, :pg_institution, :pf_no, :aadhar_no, :health_insurance_card_no, :nationality, :current_address )
    end
end