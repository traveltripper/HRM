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
    
    @leave_approved = @emp.leave.where(:status => [true, false], :created_at => @leave_from_date..@leave_to_date).limit(15)    
    @leave_waiting_for_approve = @emp.leave.where(status: nil, :created_at => @leave_from_date..@leave_to_date).limit(15)
  end
  
  def show
    @leave= Leave.find(params[:id])
    unless (([@leave.employee , @leave.employee.manager].include? current_employee) || current_employee.role.name == "HR")
      redirect_to root_path
    end

    add_breadcrumb "Leave Details"
  end

  def new
    @employee = current_employee
    @leave = @employee.leave.new
    add_breadcrumb "Apply Leave", new_leave_path
  end

  def edit
    @leave= Leave.find(params[:id])
    unless (([@leave.employee , @leave.employee.manager].include? current_employee) || current_employee.role.name == "HR")
      redirect_to root_path
    end
  end

  def create
    
     @emp = current_employee
     @leave = current_employee.leave.create(leave_params)    
     
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
    respond_to do |format|
      if @leave.update(leave_params)
        format.html { redirect_to @leave, notice: 'Leave was successfully updated.' }
        format.json { render :show, status: :ok, location: @leave }
      else
        format.html { render :edit }
        format.json { render json: @leave.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @leave = Leave.find(params[:id])
    @leave.destroy
    respond_to do |format|
      format.html { redirect_to leave_index_path, notice: 'Leave was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def leave_applied_by_team
    @emp = current_employee
    @subordinates = @emp.subordinates 
    @emp_ids = @subordinates.all.map(&:id)
    @leave_from_date = 3.month.ago.beginning_of_month
    @leave_to_date = Time.now
    @leaves = Leave.where(:created_at => @leave_from_date..@leave_to_date )    
    @team_leave = @leaves.where(employee_id: @emp_ids)
    @leave_approved_recently = @team_leave.where(:status => [true, false]).limit(10)
    @leave_waiting_for_approve = @team_leave.where(status: nil)
    
    add_breadcrumb "Leave Management", :leave_index_path
    add_breadcrumb "Leave applied by team", leave_applied_by_team_path
  end

  def leave_status
    @leave = Leave.find(params[:id])
    @emp = @leave.employee

    @leave_used = @emp.leave_used
    @requested_leave = @leave.no_of_days

    params[:leaveStatus] == "approve" ? status = true : status = false

    status == true ? @leave_used = (@leave_used + @requested_leave) : @leave_used
      
    respond_to do |format|     
      if @leave.update_attributes(:status => status, :reject_reason => params[:leave]["reject_reason"])
        @emp.update_attribute(:leave_used, @leave_used)
        LeaveMailer.employee_leave_status(@emp, @leave).deliver_later
        format.html { redirect_to leave_index_path, notice: 'Leave status mailed to Employee' }
      else
        format.html { render :edit }
      end
    end
  end
  
  private
  def leave_params
      params.require(:leave).permit(:employee_id, :no_of_days, :status, :leavetype_id, :fromdate, :todate, :reason, :reject_reason)
  end
  
end

