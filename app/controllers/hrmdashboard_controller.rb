class HrmdashboardController < ApplicationController
  before_action :authenticate_employee!
  layout 'hrmdashboard'  
  before_action :check_password_changed  

  def index
  	@emp = current_employee
    @team = Employee.where(:department_id=> @emp.department_id).where.not(:id => @emp.id).ordered_by_first_name      
  	@leave_used = @emp.leave_used
  	@available_leave = @emp.days_of_leave - @leave_used  	
  	@request_pending = @emp.leave.where("status IS ? and leave_cancel =?", nil, false).count  
  	@announcements = Announcement.where(active: true).limit(4)    
    @names = []    
    @employees=Employee.all
    # employee_emails = {}
    # @employees.each do |f|
    #   employee_emails[f.fullname] = f.email
    # end
    # @employees.each do |u| 
    #   # if u.actual_dob+(Date.today.year-u.actual_dob.year).years >= Date.yesterday && u.actual_dob+(Date.today.year-u.actual_dob.year).years <= Date.tomorrow
    #   #     @names << u.first_name 
    #   # end
    # end   
  end

  def team
    @emp = current_employee
    @announcements = Announcement.where(active: true).limit(4)

    testadmin = Employee.where(:email => "traveltripperhrm@traveltripper.com").first   
     @team = Employee.where.not(id: [@emp.id, testadmin.id]).where(status: "Active").order('first_name ASC')

    if (params[:search_term].present?) && (params[:department_id].present?)
      @team = @team.where("ttid LIKE ? or LOWER(first_name) LIKE ? or LOWER(middle_name) LIKE ? or LOWER(last_name) LIKE ? or LOWER(email) LIKE ? or contact_no LIKE ?", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%").where(department_id: params[:department_id] )
    elsif params[:search_term].present?
      @team = @team.where("ttid LIKE ? or LOWER(first_name) LIKE ? or LOWER(middle_name) LIKE ? or LOWER(last_name) LIKE ? or LOWER(email) LIKE ? or contact_no LIKE ?", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%")
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

  def payroll
    @employee = current_employee
    @payroll = @employee.payrolls.last
    @payrolls = @employee.payrolls
  end

  def check_password_changed
   unless current_employee.password_changed
     redirect_to change_password_path, alert: "You must change your password before logging in for the first time"
   end
  end
end