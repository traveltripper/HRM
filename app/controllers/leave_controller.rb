class LeaveController < ApplicationController
  layout 'dashboard'
  def index
  end
  
  def show
    @leave= Leave.find(params[:id])
  end

  def new
    @employee = current_employee
    @leave = @employee.leave.new
  end

  def create
     @leave = current_employee.leave.build(leave_params)
     #@leave.approver_id= current_user.manager_id
    if @leave.save
      flash[:success] = "Leave Applied"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
  end

  def approve
    set_status("Approved")
  end

  def reject
    set_status("Rejected")
  end
    private
  def leave_params
      params.require(:leave).permit(:employee_id, :status, :leavetype_id, :fromdate, :todate, :reason)
  end

  def set_status(status)
    @leave= Leave.find(params[:id])
      @leave.status=status
      if @leave.save
        redirect_to root_url
      end
  end
end
