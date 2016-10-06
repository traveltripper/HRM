class LeaveController < ApplicationController
  before_action :authenticate_employee!
  layout 'dashboard'
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Leave Management", :leave_index_path
  
  def index
    @emp = current_employee
    @leave_from_date = 1.month.ago.beginning_of_month
    @leave_to_date = Time.now
    @leaves = Leave.all.where(:created_at => @leave_from_date..@leave_to_date)
    
    if @emp.role.name == "HR"      
      @emp_leaves_waiting_for_approval = @leaves.where(:status => nil).limit(15) 
      @emp_leaves_approved_recently = @leaves.where(:status => [true, false]).limit(15) 
    end
    
    @leave_approved = @emp.leave.where(:status => [true, false]).limit(5)    
    @leave_waiting_for_approve = @emp.leave.where(status: nil).limit(5)
  end
  
  def show
    @leave= Leave.find(params[:id])    
    add_breadcrumb "Leave Details"
  end

  def new
    @employee = current_employee
    @leave = @employee.leave.new
    add_breadcrumb "Apply Leave", new_leave_path
  end

  def edit
    @leave= Leave.find(params[:id])
  end

  def create
    p "..create beginning....."
     @emp = current_employee
     @leave = current_employee.leave.create(leave_params)    
     p ".......create end........."  
    # if @leave.save
    #   #LeaveMailer.employee_leave_request_email(@emp, @leave).deliver_later
    #   flash[:success] = "You have applied leave successfully and an e-mail will be sent to HR and Manager. Waiting for approval."
    #   redirect_to root_url
    # else
    #   render 'new'
    # end
  end

  def update     
    @leave = Leave.find(params[:id])
    if params[:chkNo] == "approve"
      @leave.update_attribute(:status, true)
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Employee leave is approved' }
      end
    else
      @leave.update_attributes(:status => false, :reject_reason => params[:leave][:reject_reason])      
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Employee leave is rejected' }
      end
    end    
  end

  def leave_applied_by_team
    @emp = current_employee
    @subordinates = @emp.subordinates 
    @emp_ids = @subordinates.all.map(&:id)
    @leave_from_date = 1.month.ago.beginning_of_month
    @leave_to_date = Time.now
    @leaves = Leave.all.where(:created_at => @leave_from_date..@leave_to_date)    
    @team_leave = @leaves.where(employee_id: @emp_ids)
    @leave_approved_recently = @team_leave.where(:status => [true, false]).limit(10)
    @leave_waiting_for_approve = @team_leave.where(status: nil)
    add_breadcrumb "Leave Management", :leave_index_path
    add_breadcrumb "Leave applied by team", leave_applied_by_team_path
  end
  
  private
  def leave_params
      params.require(:leave).permit(:employee_id, :no_of_days, :status, :leavetype_id, :fromdate, :todate, :reason, :reject_reason)
  end

  
end
