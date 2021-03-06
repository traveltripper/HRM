class EmployeesController < ApplicationController
  before_action :authenticate_employee!
  before_filter :require_permission, :only => [:index, :new, :edit, :create, :destroy]
  layout 'dashboard'
  add_breadcrumb "Home", :root_path
  respond_to :json
  include EmployeesHelper

  def index
  	@employee = current_employee
    @employees = Employee.all.order('first_name ASC')
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

  def profile
    @employee = current_employee
    add_breadcrumb "Profile", profile_path
  end

  def edit_profile
    @employee = current_employee
    render :layout => 'hrmdashboard'    
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

  def get_leave_used
    @employee = Employee.find(params[:employee_id])    
  end

  def update_leave_used
    @employee = Employee.find(params[:employee_id])
    @employee.update_attributes(leave_used: params["employee"]["leave_used"], days_of_leave: params["employee"]["days_of_leave"], work_from_home_used: params["employee"]["work_from_home_used"]   )
    @employee.update_attributes(sick_leaves_available: params["employee"]["sick_leaves_available"], casual_leaves_available: params["employee"]["casual_leaves_available"] )
    @employee.save
    redirect_to employees_path
    
  end

  def require_permission
    unless current_employee.role.name.in?(['HR', 'Admin'])
      redirect_to dashboard_path
    end
  end    

  def send_welcome_email
    @employee = Employee.find(params[:employee_id])
    @random_password = (0...10).map { ('a'..'z').to_a[rand(26)] }.join
    @employee.password = @random_password
    @employee.password_confirmation = @random_password
    @employee.welcome_email_sent = true
    if @employee.save
      EmployeeMailer.welcome_email(@employee, @random_password).deliver_later
      redirect_to employees_path, notice: "Welcome Email successfully sent to employee"
    end
  end
  
  def team    
    @team = Employee.where(:department_id=> current_employee.department_id)
    add_breadcrumb "Team", team_path
  end

  def birthdays  
    @employees = Employee.all
    p startmonth = params[:start]
    p endmonth =  params[:end] 
    add_breadcrumb "Employees Birthday Calendar", :birthdays_path
  end

  def get_emails_and_name
    @emp = Employee.all.pluck :email, :first_name
    render json: @emp
  end

  def get_current_employee_role
    render json: {role: current_employee.role.name}
  end

  def import
    Employee.import(params[:file])
    redirect_to employees_path, notice: "Employees imported."
  end

  def change_password
    @employee = current_employee
    render :layout => 'application'    
  end

  def update_password
    @employee = current_employee
    if params[:password] != params[:password_confirmation]
      redirect_to root_path, :notice => "your password and confirmation password do not match"
    end
    @employee.update_attributes(:password => params[:password], :password_confirmation => params[:password_confirmation], password_changed: true)    
    if @employee.save
      redirect_to root_path
    end
  end

  def org_tree
    data_table = GoogleVisualr::DataTable.new
    @emp = Employee.find(params[:employee_id])
    # @emp = Employee.first
    @subordinates = []

    @emp.subordinates.each do |f|
      @subordinates << [ {:v => "#{f.fullname}" , :f => "#{f.fullname}<div style='color:red; font-style:italic'>#{f.designation}<div>"}  , @emp.fullname, f.fullname]
    end

    all_managers(@emp.id)      

    data_table.new_column('string', 'Name'   )
    data_table.new_column('string', 'Manager')
    data_table.new_column('string', 'ToolTip')
    
    data_table.add_rows @subordinates 

    opts   = { :allowHtml => true }
    @chart = GoogleVisualr::Interactive::OrgChart.new(data_table, opts)
    respond_to do |format|
        format.html {render :layout => 'hrmdashboard'}
        format.js
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:employee).permit( :current_address, :marital_status, :contact_no, :emergency_contact_no, :emergency_name, :personal_email, :skype_id, :about_me, :profile_picture, :work_from_home_used )
    end

    def employee_params
      params.require(:employee).permit(:first_name, :middle_name, :last_name, :manager_id, :role_id, :department_id, :ttid, :email, :personal_email, :contact_no, :emergency_name, :emergency_contact_no, :actual_dob, :certificate_dob, :previous_employer, :prev_years_of_exp, :pg, :graduation, :source_of_hire, :pancard_no, :passport_no, :status, :lwd, :date_of_resignation, :address, :password, :password_confirmation, :blood_group, :father_or_spouse, :marital_status, :graduation_institution, :graduation_university, :pg_university, :pg_institution, :pf_no, :aadhar_no, :health_insurance_card_no, :nationality, :current_address, :profile_picture, :date_of_joining, :days_of_leave, :leave_used, :skype_id, :about_me, :designation, :no_of_health_ins_cards_issued, :work_from_home_used, :sick_leaves_available, :casual_leaves_available, :maternity_leaves, :paternity_leaves, :leave_count)
    end
end