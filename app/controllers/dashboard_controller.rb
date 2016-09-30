class DashboardController < ApplicationController
  before_action :authenticate_employee!
  layout 'dashboard'
  def index
  	@emp = current_employee

    if @emp.role.name == "HR"
      @leaves = Leave.all
      @emp_leaves_waiting_for_approval = Leave.where(:status => nil)
      @emp_leaves_approved_recently = Leave.where(:status => [true, false])
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
end
