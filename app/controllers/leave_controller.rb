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
     p "..........."
     p @fromdate = leave_params[:fromdate].to_date
     p @todate = leave_params[:todate].to_date           
     p @no_of_days = (@todate - @fromdate) + 1
     p "..........."
     @leave.no_of_days = @no_of_days
    if @leave.save
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
      params.require(:leave).permit(:employee_id, :status, :leavetype_id, :fromdate, :todate, :reason)
  end

  
end
