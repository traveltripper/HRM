class HrmdashboardController < ApplicationController
  before_action :authenticate_employee!
  layout 'hrmdashboard'  

  def index
  	@emp = current_employee
  	@team = Employee.where(:department_id=> @emp.department_id)
  	@payroll = @emp.payrolls.first
  	@leave_used = @emp.leave_used
  	@available_leave = @emp.days_of_leave - @leave_used  	
  	@request_pending = @emp.leave.where(status: nil).count  
  	@announcements = Announcement.limit(4)
    @today_birthdays = Employee.find_by_sql("select first_name from employees where date_format(actual_dob, '%m%d') = date_format(now(), '%m%d')") 	
    @names = []
    @today_birthdays.each do |name|
      @names << name.first_name
    end
  end

  def team
    @emp = current_employee
    @team = Employee.where(:department_id=> @emp.department_id)
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
end
