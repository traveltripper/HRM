class LeaveController < ApplicationController
  before_action :authenticate_employee!
  layout 'hrmdashboard'
  before_action :find_leave, only: [:show, :edit,  :update, :destroy, :leave_cancel, :cancel_approved_leave, :leave_reject, :leave_status, :leave_status_approve, :leave_status_reject, :leave_details]
  before_action :find_leave_type, only: [:update, :leave_cancel, :cancel_approved_leave, :leave_status, :leave_status_approve, :leave_status_reject]
  def index
    @emp = current_employee
    @leave_from_date = 3.month.ago.beginning_of_month
    @leave_to_date = Time.now
    # Employee Leaves
    @leave_used = @emp.leave_used  
    @available_leave = 32 - @leave_used
    @request_pending = @emp.leave.where("status IS ? and leave_cancel =? and work_from_home =?", nil, false, false).count
    @emp_leaves = @emp.leave.where(:created_at => @leave_from_date..@leave_to_date, work_from_home: false)       
    @leave_approved = @emp_leaves.status_true_or_false | @emp_leaves.where("status IS ? and leave_cancel =?", nil, true)
    @leave_waiting_for_approve = @emp_leaves.where(status: nil, leave_cancel:false).limit(15)
    # Employee Work From Home
    @work_from_home_used = @emp.work_from_home_used
    @available_work_from_home = 32 - @work_from_home_used
    @emp_work_from_home = @emp.leave.where(:created_at => @leave_from_date..@leave_to_date, work_from_home: true)    
    @work_from_home_approved = @emp_work_from_home.status_true_or_false | @emp_work_from_home.where("status IS ? and leave_cancel =?", nil, true)  
    @work_from_home_waiting_for_approve = @emp_work_from_home.where(status: nil, leave_cancel:false).limit(15)
  end
  
  def show
    #@leave = Leave.find(params[:id])
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
    #@leave = Leave.find(params[:id])
    unless (([@leave.employee , @leave.employee.manager].include? current_employee) || current_employee.role.name.in?(['HR', 'Admin']))
      redirect_to root_path
    end
  end

  def create 
    @emp = current_employee
    @leave = current_employee.leave.new(leave_params)
    if @leave.work_from_home == false
      current_leavetype = leave_params[:leavetype_id].to_i
      limit = Leavetype.where(:id => current_leavetype).first.limit
      leave_type_name = Leavetype.where(:id => current_leavetype).first.name
      # @available_leaves = 0
      if leave_type_name == "Sick"
        @available_leaves = @emp.sick_leaves_available
      elsif leave_type_name == "Casual/Privilege"
        @available_leaves = @emp.casual_leaves_available
      elsif leave_type_name == "Maternity"
        @available_leaves = 0
      elsif leave_type_name == "Paternity"
         @available_leaves = 0
      end 

      if @available_leaves <= limit && @available_leaves > 0
        if @leave.save
          flash[:flash] = "You have applied #{leave_type_name} successfully and an e-mail will be sent to HR and Manager. Waiting for approval." 
          redirect_to leave_index_path
          LeaveMailer.employee_leave_request_email(@emp, @leave).deliver_later      
          LeaveMailer.leave_request_email_to_hr(@emp, @leave).deliver_later
          if @emp.manager 
            LeaveMailer.team_leave_request_email(@emp, @leave).deliver_later
          end
        else
          render 'edit'
        end
      else
          flash[:error] ="the #{@leave_type_name} type exceeded limit, so apply another type of leave"
          redirect_to leave_index_path
      end
    else
      if @leave.save
          flash[:flash] = "You have applied Work From Home successfully and an e-mail will be sent to HR and Manager. Waiting for approval." 
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
  end

  def update
    @emp = current_employee
    @leave = Leave.find(params[:id])
    #@leave.work_from_home == false ? type = "leave" : type = "work from home"
    respond_to do |format|
      if @leave.update(leave_params)
        format.html { redirect_to leave_index_path, notice: "#{@type} updated successfully and an e-mail will be sent to HR and Manager. Waiting for approval." }
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
    #@leave = Leave.find(params[:id])
    @leave.destroy
    respond_to do |format|
      format.html { redirect_to leave_index_path }
      format.json { head :no_content }
      format.js
    end
  end

  def team_leave_details
    @employee = current_employee
    if current_employee.role.name == "Manager"
      @team = @employee.subordinates    
    else
      redirect_to root_path
    end
  end

  def leave_cancel
    #@leave = Leave.find(params[:id])
    @emp = current_employee
    #@leave.work_from_home == false ? type = "leave" : type = "work from home"
    if @leave.update_attribute(:leave_cancel, true)
      redirect_to leave_index_path, notice: "Your #{@type} is cancelled and an e-mail will be sent to HR and Manager. "
      LeaveMailer.employee_cancel_leave_request_email(@emp, @leave).deliver_later      
      LeaveMailer.leave_cancel_request_email_to_hr(@emp, @leave).deliver_later
      if @emp.manager 
        LeaveMailer.team_cancel_leave_request_email(@emp, @leave).deliver_later
      end
    end
  end

  def cancel_approved_leave
    #@leave = Leave.find(params[:id])
    #@leave.work_from_home == false ? type = "leave" : type = "work from home"
    @emp = @leave.employee
    requested_leave_days = @leave.no_of_days
    if @leave.work_from_home == false
      leave_used = @emp.leave_used
      leave_used = leave_used - requested_leave_days
      @emp.update_attribute(:leave_used, leave_used)
      if @leave.leavetype.name == "Sick"
        sick_leaves_available = @emp.sick_leaves_available
        sick_leaves_available = sick_leaves_available  + requested_leave_days
        @emp.update_attribute(:sick_leaves_available, sick_leaves_available)
      elsif @leave.leavetype.name == "Casual/Privilege"
        casual_leaves_available = @emp.casual_leaves_available
        casual_leaves_available = casual_leaves_available  + requested_leave_days
        @emp.update_attribute(:casual_leaves_available, casual_leaves_available)
      end
      binding.pry
    else
      work_from_home_used = @emp.work_from_home_used
      work_from_home_used = work_from_home_used - requested_leave_days
      @emp.update_attribute(:work_from_home_used, work_from_home_used)
    end
    @leave.leave_cancel = true
    @leave.status = nil    
    if @leave.save
      redirect_to leave_index_path, notice: "Your #{@type} is cancelled and an e-mail will be sent to HR and Manager."
      LeaveMailer.employee_cancel_leave_request_email(@emp, @leave).deliver_later      
      LeaveMailer.leave_cancel_request_email_to_hr(@emp, @leave).deliver_later
      if @emp.manager 
        LeaveMailer.team_cancel_leave_request_email(@emp, @leave).deliver_later
      end
    end
  end

  def leave_reject
    #@leave = Leave.find(params[:id])
  end

  def leave_applied_by_team
    @emp = current_employee
    @leaves = Leave.where(:created_at => 3.month.ago.beginning_of_month..Time.now )
    @emp_ids = @emp.subordinates.where.not(id: @emp.id).map(&:id) 
    # Team Leaves       
    @team_leave = @leaves.where(employee_id: @emp_ids, work_from_home: false)
    @leave_approved_recently = @team_leave.status_true_or_false | @team_leave.where("status IS ? and leave_cancel =?", nil, true)
    @leave_waiting_for_approve = @team_leave.where(status: nil, leave_cancel: false)
    # Team Work From Home
    @team_work_from_home = @leaves.where(employee_id: @emp_ids, work_from_home: true)
    @team_wfh_approved_recently = @team_work_from_home.status_true_or_false | @team_leave.where("status IS ? and leave_cancel =?", nil, true)
    @team_wfh_waiting_for_approve = @team_work_from_home.where(status: nil, leave_cancel: false)
  end

  def leave_applied_by_employees
    @emp = current_employee    
    # Employees Leaves
    @leaves = Leave.where(:created_at => 3.month.ago.beginning_of_month..Time.now, work_from_home: false)         
    @emp_leaves_waiting_for_approval = @leaves.where(:status => nil, leave_cancel: false)
    @emp_leaves_approved_recently = @leaves.status_true_or_false | @leaves.where("status IS ? and leave_cancel =?", nil, true) 
    # Employees Work From Home
    @wfh = Leave.where(:created_at => 3.month.ago.beginning_of_month..Time.now, work_from_home: true)         
    @emp_wfh_waiting_for_approval = @wfh.where(:status => nil, leave_cancel: false)
    @emp_wfh_approved_recently = @wfh.status_true_or_false | @leaves.where("status IS ? and leave_cancel =?", nil, true) 
  end


  def leave_status
    #@leave = Leave.find(params[:id])
    #@leave.work_from_home == false ? type = "leave" : type = "work from home"
    @emp = @leave.employee
    @requested_leave = @leave.no_of_days
    params[:leaveStatus] == "approve" ? status = true : status = false
    if @leave.work_from_home == false
      @leave_used = @emp.leave_used    
      status == true ? @leave_used = (@leave_used + @requested_leave) : @leave_used
      @emp.update_attribute(:leave_used, @leave_used)
      if @leave.leavetype.name == "Sick"
        status == true ? @sick_leaves_available = (@sick_leaves_available - @requested_leave) : @sick_leaves_available 
        @emp.update_attribute(:sick_leaves_available, @sick_leaves_available)
      elsif @leave.leavetype.name == "Casual/Privilege"
        status == true ? @casual_leaves_available = (@casual_leaves_available - @requested_leave) : @casual_leaves_available 
        @emp.update_attribute(:casual_leaves_available, @casual_leaves_available)
      end
      binding.pry
    else
      @work_from_home_used = @emp.work_from_home_used
      status == true ? @work_from_home_used = (@work_from_home_used + @requested_leave) : @work_from_home_used  
      @emp.update_attribute(:work_from_home_used, @work_from_home_used)
    end
    
    respond_to do |format|     
      if @leave.update_attributes(:status => status, :reject_reason => params[:leave]["reject_reason"])        
        LeaveMailer.employee_leave_status(@emp, @leave).deliver_later
        LeaveMailer.employee_leave_status_to_hr(@emp, @leave).deliver_later
        if current_employee.role.name.in?(['HR', 'Admin'])
          format.html { redirect_to employees_leave_path, notice: "The employee #{@emp.fullname} #{@type} has #{@leave.status == true ? "approved" : "Rejected"}  and an email has been sent to employee and HR." }
        else
          format.html { redirect_to team_leave_path, notice: "The employee #{@emp.fullname} #{@type} has #{@leave.status == true ? "approved" : "Rejected"} and an email has been sent to employee and HR." }
        end
      else
        format.html { render :edit }
      end
    end
  end


  def leave_status_approve    
    #@leave = Leave.find(params[:id])
    #@leave.work_from_home == false ? type = "leave" : type = "work from home"
    @emp = @leave.employee
    @requested_leave = @leave.no_of_days
    if @leave.work_from_home == false
      @leave_used = @emp.leave_used
      @leave_used = (@leave_used + @requested_leave)
      @emp.update_attribute(:leave_used, @leave_used)
      if @leave.leavetype.name == "Sick"
        @sick_leaves_available = @emp.sick_leaves_available
        @sick_leaves_available = (@sick_leaves_available - @requested_leave)
        @emp.update_attribute(:sick_leaves_available, @sick_leaves_available)
      elsif @leave.leavetype.name == "Casual/Privilege"
        @casual_leaves_available = @emp.casual_leaves_available
        @casual_leaves_available = (@casual_leaves_available - @requested_leave)
        @emp.update_attribute(:casual_leaves_available, @casual_leaves_available)
      end
      binding.pry
    else
      @work_from_home_used = @emp.work_from_home_used
      @work_from_home_used = (@work_from_home_used + @requested_leave)
      @emp.update_attribute(:work_from_home_used, @work_from_home_used)
    end
    respond_to do |format|     
      if @leave.update_attributes(:status => true)        
        LeaveMailer.employee_leave_status(@emp, @leave).deliver_later
        LeaveMailer.employee_leave_status_to_hr(@emp, @leave).deliver_later
        if current_employee.role.name.in?(['HR', 'Admin'])
          format.html { redirect_to employees_leave_path, notice: "The employee #{@emp.fullname} #{@type} has approved and an email has been sent to employee and HR." }
        else
          format.html { redirect_to team_leave_path, notice: "The employee #{@emp.fullname} #{@type} has approved and an email has been sent to employee and HR." }
        end
      else
        format.html { render :edit }
      end
    end       
  end

  def leave_status_reject    
    #@leave = Leave.find(params[:id])
    #@leave.work_from_home == false ? type = "leave" : type = "work from home"
    @emp = @leave.employee
    respond_to do |format|     
      if @leave.update_attributes(:status => false, :reject_reason => params[:leave]["reject_reason"])
        LeaveMailer.employee_leave_status(@emp, @leave).deliver_later
        LeaveMailer.employee_leave_status_to_hr(@emp, @leave).deliver_later
        if current_employee.role.name.in?(['HR', 'Admin'])
          format.html { redirect_to employees_leave_path, notice: "The employee #{@emp.fullname} #{@type} has #{@leave.status == true ? "approved" : "Rejected"}  and an email has been sent to employee and HR." }
        else
          format.html { redirect_to team_leave_path, notice: "The employee #{@emp.fullname} #{@type} has #{@leave.status == true ? "approved" : "Rejected"} and an email has been sent to employee and HR." }
        end
      else
        format.html { render :edit }
      end
    end       
  end


  def leave_details
    #@leave = Leave.find(params[:id])
    unless (([@leave.employee , @leave.employee.manager].include? current_employee) || current_employee.role.name.in?(['HR', 'Admin']))
      redirect_to root_path
    end
  end
  
  private

  def find_leave
    @leave = Leave.find(params[:id])
  end

  def find_leave_type
    @leave.work_from_home == false ? @type = "leave" : @type = "work from home"
  end
  
  def leave_params
      params.require(:leave).permit(:employee_id, :no_of_days, :status, :leavetype_id, :fromdate, :todate, :reason, :reject_reason, :work_from_home)
  end  
end