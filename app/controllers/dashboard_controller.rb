class DashboardController < ApplicationController
  before_action :authenticate_employee!
  layout 'dashboard'
  def index
  	@emp = current_employee
    @leave_from_date = 1.month.ago.beginning_of_month
    @leave_to_date = Time.now
    @leaves = Leave.all.where(:created_at => @leave_from_date..@leave_to_date)
    if @emp.role.name == "HR"      
      @emp_leaves_waiting_for_approval = @leaves.where(:status => nil).limit(15)
      @emp_leaves_approved_recently = @leaves.where(:status => [true, false]).limit(15)
    end

    if @emp.role.name == "Manager"
      @subordinates = @emp.subordinates 
      @emp_ids = @subordinates.all.map(&:id)
      @team_leave = @leaves.where(employee_id: @emp_ids)
      @leave_approved_recently = @team_leave.where(:status => [true, false]).limit(10)
      @team_leave_waiting_for_approve = @team_leave.where(status: nil)
    end
    
    @leave_approved = @emp.leave.where(:status => [true, false]).limit(5)    
    @leave_waiting_for_approve = @emp.leave.where(status: nil).limit(5)
    add_breadcrumb "Dashboard", dashboard_path
  end
end
