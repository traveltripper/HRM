class EmployeesController < ApplicationController
  before_action :authenticate_employee!
  #before_filter(:only => [:index, :show]) { unauthorized! if cannot? :read, :Employee }
  before_filter :require_permission, :only => [:index, :new, :edit, :create, :update, :destroy]
  layout 'dashboard'
  add_breadcrumb "Home", :root_path
  respond_to :json
  def index
  	@employee = current_employee
    @employees = Employee.all
  end

  def search
    @employees = Employee.all
    if params[:search]
      first_name =  params[:search]
      p @employees = Employee.where("first_name LIKE ?", "%#{first_name}%")
    else
      @employees = Employee.all.order('created_at DESC')
    end 
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
    @emp = current_employee

    if @emp.role.name == "HR"
      @leaves = Leave.all
    end

    if @emp.role.name == "Manager"
      @subordinates = @emp.subordinates 
      @emp_ids = @subordinates.all.map(&:id)
      @team_leave = Leave.where(employee_id: @emp_ids).order('created_at ASC')
      @leave_approved_recently = @team_leave.where(:status => [true, false]).limit(20)
      @team_leave_waiting_for_approve = @team_leave.where(status: nil)
    end
    
    @leave_approved = @emp.leave.where(status: !nil).limit(5)    
    @leave_waiting_for_approve = @emp.leave.where(status: nil).limit(5)
    add_breadcrumb "Dashboard", dashboard_path
  end

  def reports
    add_breadcrumb "Reports", reports_path
  end

  def profile
    @employee = current_employee
    add_breadcrumb "Profile", profile_path
  end

  def require_permission
  if current_employee.role.name != "HR" 
    redirect_to dashboard_path
  end
  end

  def leave_applied_by_team
    @emp = current_employee
    @subordinates = @emp.subordinates 
    @emp_ids = @subordinates.all.map(&:id)
    @team_leave = Leave.where(employee_id: @emp_ids).order('created_at ASC')
    @leave_approved_recently = @team_leave.where(:status => [true, false]).limit(20)
    @leave_waiting_for_approve = @team_leave.where(status: nil)
    add_breadcrumb "Leave applied by team", leave_applied_by_team_path
  end
  
  def team
    @emp = current_employee
    if current_employee.role.name != "Manager"
      redirect_to dashboard_path
    end
    add_breadcrumb "Team", team_path
  end

  def birthdays
    @emp = Employee.all
    events = []
    @emp.each do |e|
      events << {:id => e.id }
    end
    #render :text => events.to_json    
    add_breadcrumb "birthdays", :birthdays_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:first_name, :middle_name, :last_name, :manager_id, :role_id, :department_id, :ttid, :email, :personal_email, :contact_no, :emergency_name, :emergency_contact_no, :actual_dob, :certificate_dob, :doj, :prev_years_of_exp, :pg, :graduation, :source_of_hire, :pancard_no, :passport_no, :status, :lwd, :date_of_resignation, :address, :password, :password_confirmation )
    end
end