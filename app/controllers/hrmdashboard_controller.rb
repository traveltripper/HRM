class HrmdashboardController < ApplicationController
  before_action :authenticate_employee!
  layout 'hrmdashboard'  

  def index
  	@emp = current_employee
  	@team = Employee.where(:department_id=> @emp.department_id)
  	@payroll = @emp.payrolls.last
  	@leave_used = @emp.leave_used
  	@available_leave = @emp.days_of_leave - @leave_used  	
  	@request_pending = @emp.leave.where(status: nil).count  
  	@announcements = Announcement.limit(4)	
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
  end
end
