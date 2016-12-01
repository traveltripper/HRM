class HrmdashboardController < ApplicationController
  before_action :authenticate_employee!
  layout 'hrmdashboard'  
  require 'json'
  before_action :check_password_changed  

  def index
  	@emp = current_employee
    #if current_employee.role.name.in?(['Admin', 'HR'])
      #@team = Employee.where.not(:id => @emp.id).ordered_by_first_name.limit(6)
    @team = Employee.where(:department_id=> @emp.department_id).where.not(:id => @emp.id).ordered_by_first_name      
    #else
     # @team = Employee.where(:department_id=> @emp.department_id).where.not(:id => @emp.id).ordered_by_first_name
    #end
  	#@payroll = @emp.payrolls.first
  	@leave_used = @emp.leave_used
  	@available_leave = @emp.days_of_leave - @leave_used  	
  	@request_pending = @emp.leave.where("status IS ? and leave_cancel =?", nil, false).count  
  	@announcements = Announcement.where(active: true).limit(4)    
    @names = []    
    @employees=Employee.all
    employee_emails = {}
    @employees.each do |f|
      employee_emails[f.fullname] = f.email
    end
    # @employees.each do |u| 
    #   # if u.actual_dob+(Date.today.year-u.actual_dob.year).years >= Date.yesterday && u.actual_dob+(Date.today.year-u.actual_dob.year).years <= Date.tomorrow
    #   #     @names << u.first_name 
    #   # end
    # end 

    File.open("public/temp.json","w") do |f|
      f.write(employee_emails.to_json)
    end  
  end

  def team
    @emp = current_employee
    @announcements = Announcement.limit(4)  
    testadmin = Employee.where(:email => "traveltripperhrm@traveltripper.com").first   
    #if current_employee.role.name.in?(['Admin', 'HR'])
      @team = Employee.where.not(id: [@emp.id, testadmin.id]).where(status: "Active").order('first_name ASC')
    #else
      #@team = Employee.where(:department_id=> @emp.department_id).where.not(:id => @emp.id).order('first_name ASC')
    #end

    if params[:employee_id]

      if @emp.id == params[:employee_id].to_i
        redirect_to profile_path
      else

      if current_employee.role.name.in?(['Admin', 'HR'])
      elsif current_employee.department_id != Employee.find(params[:employee_id]).department_id
        redirect_to team_path
      end         
      @team_employee = Employee.where(:id=>params[:employee_id]).first
      @team_emp_id = @team_employee.id
      end
    end
  end

  def employee_details
    @emp = Employee.find(params[:id])
    respond_to do |format|
      format.js    
    end
  end

  def profile
    @employee = current_employee
  end

  def events
    @events = Event.all
  end

  def payroll
    @employee = current_employee
    @payroll = @employee.payrolls.last
    @payrolls = @employee.payrolls
  end

  def check_password_changed
   unless current_employee.password_changed
     redirect_to change_password_path, alert: "You must change your password before logging in for the first time"
   end
  end
end