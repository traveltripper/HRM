class HrmdashboardController < ApplicationController
  before_action :authenticate_employee!
  layout 'hrmdashboard'  
  before_action :check_password_changed  

  def index
  	@emp = current_employee
    @team = Employee.where(:department_id=> @emp.department_id).where.not(:id => @emp.id).ordered_by_first_name      
  	@leave_used = @emp.leave_used
    # @available_leave = @emp.days_of_leave - @leave_used
    @available_leave = 32 - @leave_used  	
  	@request_pending = @emp.leave.where("status IS ? and leave_cancel =? and work_from_home =?", nil, false, false).count  
  	@announcements = Announcement.active.limit(4) 
  end

  def indexhr
    @emp = current_employee
    @team = Employee.where(:department_id=> @emp.department_id).where.not(:id => @emp.id).ordered_by_first_name      
    @leave_used = @emp.leave_used
    # @available_leave = @emp.days_of_leave - @leave_used
    @available_leave = 32 - @leave_used   
    @request_pending = @emp.leave.where("status IS ? and leave_cancel =? and work_from_home =?", nil, false, false).count  
    @leave_from_date = 3.month.ago.beginning_of_month
    @leave_to_date = Time.now
    if (params[:fromdate].present?) && (params[:todate].present?)
      if @emp.role.name == "HR" 
    # Employees Leaves 
      # @leaves = Leave.where("fromdate = ? AND todate = ?", params[:fromdate],  params[:todate])    
      @leaves = Leave.where(:fromdate => (params[:fromdate].to_time)..(params[:todate].to_time), work_from_home: false)    
      @emp_leaves_approved_recently = @leaves.where(:status => [true, false]).limit(15)
    # Employees Work From Home
      @wfh = Leave.where(:fromdate => (params[:fromdate].to_time)..(params[:todate].to_time), work_from_home: true)    
      @emp_wfh_approved_recently = @wfh.status_true_or_false | @leaves.where("status IS ? and leave_cancel =?", nil, true)
      end
    else
      if @emp.role.name == "HR" 
    # Employees Leaves 
      @leaves = Leave.where(:created_at => 3.month.ago.beginning_of_month..Time.now, work_from_home: false)    
      @emp_leaves_approved_recently = @leaves.where(:status => [true, false]).limit(15)
    # Employees Work From Home
      @wfh = Leave.where(:created_at => 3.month.ago.beginning_of_month..Time.now, work_from_home: true)    
      @emp_wfh_approved_recently = @wfh.status_true_or_false | @leaves.where("status IS ? and leave_cancel =?", nil, true)
      end
    end
  end

  def team

    @emp = current_employee
    @announcements = Announcement.active.limit(4)

    testadmin = Employee.first  
     
      @team = Employee.where.not(id: [@emp.id, testadmin.id]).ordered_by_first_name
      # @team = Employee.where.not(id: [@emp.id, testadmin.id]).active.ordered_by_first_name
        if (params[:search_term].present?) && (params[:department_id].present?)
          @team = @team.where("LOWER(ttid) LIKE ? or LOWER(first_name) LIKE ? or LOWER(middle_name) LIKE ? or LOWER(last_name) LIKE ? or LOWER(email) LIKE ? or contact_no LIKE ?", "%#{params[:search_term].downcase}%", "%#{params[:search_term].downcase}%", "%#{params[:search_term].downcase}%", "%#{params[:search_term].downcase}%", "%#{params[:search_term].downcase}%", "%#{params[:search_term].downcase}%").where(department_id: params[:department_id] )
        elsif params[:search_term].present?
          @team = @team.where("LOWER(ttid) LIKE ? or LOWER(first_name) LIKE ? or LOWER(middle_name) LIKE ? or LOWER(last_name) LIKE ? or LOWER(email) LIKE ? or contact_no LIKE ?", "%#{params[:search_term].downcase}%", "%#{params[:search_term].downcase}%", "%#{params[:search_term].downcase}%", "%#{params[:search_term].downcase}%", "%#{params[:search_term].downcase}%", "%#{params[:search_term].downcase}%")
        elsif params[:department_id].present?
          @team = @team.where("department_id =?", params[:department_id])
        else
          @team
        end
    
    if params[:employee_id]
      if @emp.id == params[:employee_id].to_i
        redirect_to profile_path
      else       
        @team_employee = Employee.where(:id=>params[:employee_id]).first
        @team_emp_id = @team_employee.id
      end
    end
  end

  def employee_details
    @emp = Employee.find(params[:id])
    respond_to do |format|
      format.js    
    end
  end

  def profile
    @employee = current_employee
  end

  # def payroll
  #   @employee = current_employee
  #   @payroll = @employee.payrolls.last
  #   @payrolls = @employee.payrolls
  # end

  def check_password_changed
   unless current_employee.password_changed
     redirect_to change_password_path, alert: "You must change your password before logging in for the first time"
   end
  end
end