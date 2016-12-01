class LeaveController < ApplicationController
  before_action :authenticate_employee!
  layout 'hrmdashboard'
  #after_action :send_emails, only: [:create]
  
  def index
    @emp = current_employee
    @leave_used = @emp.leave_used
    @available_leave = @emp.days_of_leave - @leave_used   
    @request_pending = @emp.leave.where("status IS ? and leave_cancel =?", nil, false).count
    @leave_from_date = 3.month.ago.beginning_of_month
    @leave_to_date = Time.now
    @emp_leaves = @emp.leave.where(:created_at => @leave_from_date..@leave_to_date)       
    @leave_approved = @emp_leaves.where(:status => [true, false]) | @emp_leaves.where("status IS ? and leave_cancel =?", nil, true)
    #@leave_approved2 = @emp_leaves.where(status: nil, leave_cancel: true)   
    #p "........"
    #@leave_approved = @leave_approved1 << @leave_approved2 
    @leave_waiting_for_approve = @emp.leave.where(status: nil, leave_cancel:false, :created_at => @leave_from_date..@leave_to_date).limit(15)
  end
  
  def show
    @leave= Leave.find(params[:id])
    unless (([@leave.employee , @leave.employee.manager].include? current_employee) || current_employee.role.name.in?(['HR', 'Admin']))
      redirect_to root_path
    end
  end

  def new
    @employee = current_employee
    @leave = @employee.leave.new
    add_breadcrumb "Apply Leave", new_leave_path
  end

  def edit
    @leave= Leave.find(params[:id])
    unless (([@leave.employee , @leave.employee.manager].include? current_employee) || current_employee.role.name.in?(['HR', 'Admin']))
      redirect_to root_path
    end
  end

  def create    
    @emp = current_employee
    @leave = current_employee.leave.new(leave_params)
    if @leave.save
      flash[:success] = "You have applied leave successfully and an e-mail will be sent to HR and Manager. Waiting for approval." 
      redirect_to leave_index_path
      LeaveMailer.employee_leave_request_email(@emp, @leave).deliver_later      
      LeaveMailer.leave_request_email_to_hr(@emp, @leave).deliver_later
      if @emp.manager 
        LeaveMailer.team_leave_request_email(@emp, @leave).deliver_later
      end
    else
      render 'edit'
    end       
  end

  def update
    @emp = current_employee
    @leave = Leave.find(params[:id])
    respond_to do |format|
      if @leave.update(leave_params)
        format.html { redirect_to leave_index_path, notice: 'leave updated successfully and an e-mail will be sent to HR and Manager. Waiting for approval.' }
        format.json { render :show, status: :ok, location: @leave }
        LeaveMailer.employee_leave_request_email(@emp, @leave).deliver_later      
        LeaveMailer.leave_request_email_to_hr(@emp, @leave).deliver_later
        if @emp.manager 
          LeaveMailer.team_leave_request_email(@emp, @leave).deliver_later
        end
        #format.js
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
      format.js
    end
  end

  def leave_cancel
    @leave = Leave.find(params[:id])
    @emp = current_employee
    if @leave.update_attribute(:leave_cancel, true)
      redirect_to leave_index_path
      LeaveMailer.employee_cancel_leave_request_email(@emp, @leave).deliver_later      
      LeaveMailer.leave_cancel_request_email_to_hr(@emp, @leave).deliver_later
      if @emp.manager 
        LeaveMailer.team_cancel_leave_request_email(@emp, @leave).deliver_later
      end
    end
  end

  def cancel_approved_leave
    @leave = Leave.find(params[:id])
    no_of_days = @leave.no_of_days
    days_of_leave = @leave.employee.days_of_leave
  end

  def leave_reject
    @leave = Leave.find(params[:id])
  end

  def leave_applied_by_team
    @emp = current_employee
    @leaves = Leave.where(:created_at => 3.month.ago.beginning_of_month..Time.now )
    @subordinates = @emp.subordinates.where.not(id: @emp.id) 
    @emp_ids = @subordinates.all.map(&:id)        
    @team_leave = @leaves.where(employee_id: @emp_ids)
    @leave_approved_recently = @team_leave.where(:status => [true, false]) | @team_leave.where("status IS ? and leave_cancel =?", nil, true)
    @leave_waiting_for_approve = @team_leave.where(status: nil, leave_cancel: false)
  end

  def leave_applied_by_employees
    @emp = current_employee    
    @leaves = Leave.where(:created_at => 3.month.ago.beginning_of_month..Time.now)         
    @emp_leaves_waiting_for_approval = @leaves.where(:status => nil, leave_cancel: false)
    @emp_leaves_approved_recently = @leaves.where(:status => [true, false]) | @leaves.where("status IS ? and leave_cancel =?", nil, true)  
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
        LeaveMailer.employee_leave_status_to_hr(@emp, @leave).deliver_later
        if current_employee.role.name.in?(['HR', 'Admin'])
          format.html { redirect_to employees_leave_path, notice: "The employee #{@emp.fullname} leave has #{@leave.status == true ? "approved" : "Rejected"}  and an email has been sent to employee and HR." }
        else
          format.html { redirect_to team_leave_path, notice: "The employee #{@emp.fullname} leave has #{@leave.status == true ? "approved" : "Rejected"} and an email has been sent to employee and HR." }
        end
      else
        format.html { render :edit }
      end
    end
  end

  def leave_status_approve    
    @leave = Leave.find(params[:id])
    @emp = @leave.employee
    @leave_used = @emp.leave_used
    @requested_leave = @leave.no_of_days
    @leave_used = (@leave_used + @requested_leave)
    respond_to do |format|     
      if @leave.update_attributes(:status => true)
        @emp.update_attribute(:leave_used, @leave_used)
        LeaveMailer.employee_leave_status(@emp, @leave).deliver_later
        LeaveMailer.employee_leave_status_to_hr(@emp, @leave).deliver_later
        if current_employee.role.name.in?(['HR', 'Admin'])
          format.html { redirect_to employees_leave_path, notice: "The employee #{@emp.fullname} leave has approved and an email has been sent to employee and HR." }
        else
          format.html { redirect_to team_leave_path, notice: "The employee #{@emp.fullname} leave has approved and an email has been sent to employee and HR." }
        end
      else
        format.html { render :edit }
      end
    end       
  end

  def leave_status_reject    
    @leave = Leave.find(params[:id])
    p "............"
    p params
    p "............"
    @emp = @leave.employee
    respond_to do |format|     
      if @leave.update_attributes(:status => false, :reject_reason => params[:leave]["reject_reason"])
        LeaveMailer.employee_leave_status(@emp, @leave).deliver_later
        LeaveMailer.employee_leave_status_to_hr(@emp, @leave).deliver_later
        if current_employee.role.name.in?(['HR', 'Admin'])
          format.html { redirect_to employees_leave_path, notice: "The employee #{@emp.fullname} leave has #{@leave.status == true ? "approved" : "Rejected"}  and an email has been sent to employee and HR." }
        else
          format.html { redirect_to team_leave_path, notice: "The employee #{@emp.fullname} leave has #{@leave.status == true ? "approved" : "Rejected"} and an email has been sent to employee and HR." }
        end
      else
        format.html { render :edit }
      end
    end       
  end


  def leave_details
    @leave= Leave.find(params[:id])
    unless (([@leave.employee , @leave.employee.manager].include? current_employee) || current_employee.role.name.in?(['HR', 'Admin']))
      redirect_to root_path
    end
  end

  # def send_emails     
  #   @emp = current_employee
  #   @leave = @emp.leave.last       
  # end
  
  private
  def leave_params
      params.require(:leave).permit(:employee_id, :no_of_days, :status, :leavetype_id, :fromdate, :todate, :reason, :reject_reason)
  end
  
end

