class LeaveController < ApplicationController
  layout 'dashboard'
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Leave Management", :leave_index_path
  def index
    @emp = current_employee
    if @emp.role.name == "HR"
      @leaves = Leave.all
    end
    #@all_employee_leaves = Leave.limit(10)
    @leave_approved = @emp.leave.where(status: !nil).limit(5)    
    @leave_waiting_for_approve = @emp.leave.where(status: nil).limit(5)  
    #@leaves = @emp.leave.limit(5) 
  end
  
  def show
    @leave= Leave.find(params[:id])
  end

  def new
    @employee = current_employee
    @leave = @employee.leave.new
    add_breadcrumb "Apply Leave", new_leave_path
  end

  def create
     @emp = current_employee
     @leave = current_employee.leave.build(leave_params)
    if @leave.save
      LeaveMailer.employee_leave_request_email(@emp, @leave).deliver_later
      flash[:success] = "Your leave has applied successfully and an e-mail will be sent to HR and Manager. Waiting for approval."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @leave = Leave.find(params[:id])
    p "........"
    if params[:leave][:status] == "approve"
      @leave.update_attribute(:status, true)
    else
      @leave.update_attribute(:status, false)
    end
    p "........."

    redirect_to dashboard_path
   
  end



  
  private
  def leave_params
      params.require(:leave).permit(:employee_id, :no_of_days, :status, :leavetype_id, :fromdate, :todate, :reason)
  end

  
end
