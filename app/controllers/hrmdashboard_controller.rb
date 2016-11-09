class HrmdashboardController < ApplicationController
  before_action :authenticate_employee!
  layout 'hrmdashboard'  
  before_action :check_password_changed  

  def index
  	@emp = current_employee
    @team = Employee.where(:department_id=> @emp.department_id).where.not(:id => @emp.id)
  	#@team = Employee.all
  	@payroll = @emp.payrolls.first
  	@leave_used = @emp.leave_used
  	@available_leave = @emp.days_of_leave - @leave_used  	
  	@request_pending = @emp.leave.where(status: nil).count  
  	@announcements = Announcement.limit(4)    
    @names = []    
    @employees=Employee.all
    @employees.each do |u| 
      if u.actual_dob+(Date.today.year-u.actual_dob.year).years >= Date.yesterday && u.actual_dob+(Date.today.year-u.actual_dob.year).years <= Date.tomorrow
          @names << u.first_name 
      end
    end   
  end

  def team
    @emp = current_employee
    @team = Employee.where(:department_id=> @emp.department_id).where.not(:id => @emp.id)
    #@team = Employee.all
  end

  def leave
    @emp = current_employee
    @leave_used = @emp.leave_used
    @available_leave = @emp.days_of_leave - @leave_used   
    @request_pending = @emp.leave.where(status: nil).count

    @leave_from_date = 1.month.ago.beginning_of_month
    @leave_to_date = Time.now
    @leaves = Leave.all.where(:created_at => @leave_from_date..@leave_to_date)
    
    @leave_approved = @emp.leave.where(:status => [true, false], :created_at => @leave_from_date..@leave_to_date).limit(15)    
    @leave_waiting_for_approve = @emp.leave.where(status: nil, :created_at => @leave_from_date..@leave_to_date).limit(15)
  end

  def employee_details
    @emp = Employee.find(params[:id])
    respond_to do |format|
      format.js    
    end
  end

  def profile
    @employee = current_employee
    #render :template => 'employees/profile'    
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
