class LeaveMailer < ApplicationMailer

  def employee_leave_request_email(employee, leave)
  	@employee = employee
  	@leave = leave    
    @leave.work_from_home == false ? @type = "Leave" : @type = "Work from home"
    #mail(to: "srinivas08478@gmail.com", subject: "#{@type} request")
    mail(to: @employee.email, subject: "#{@type} request")
  end

  def employee_cancel_leave_request_email(employee, leave)
    @employee = employee
    @leave = leave    
    @leave.work_from_home == false ? @type = "Leave" : @type = "Work from home"
    #mail(to: "srinivas08478@gmail.com", subject: "#{@type} cancel request")
    mail(to: @employee.email, subject: '#{@type} cancel request')
  end

  def team_leave_request_email(employee, leave)
    @employee = employee
    @leave = leave
    @leave.work_from_home == false ? @type = "Leave" : @type = "Work from home"
    @subject = @employee.fullname + " " + "#{@type} request" 
    #mail(to: "srinivas08478@gmail.com", subject: @subject)
    mail(to: @employee.manager.email, subject: @subject)
  end

  def team_cancel_leave_request_email(employee, leave)
    @employee = employee
    @leave = leave
    @leave.work_from_home == false ? @type = "Leave" : @type = "Work from home"
    @subject = @employee.fullname + " " + "#{@type} cancel request" 
    #mail(to: "srinivas08478@gmail.com", subject: @subject)
    mail(to: @employee.manager.email, subject: @subject)
  end

  def leave_request_email_to_hr(employee, leave)
    @employee = employee
    @leave = leave
    @role = Role.where(:name=>"HR").first
    @hr = Employee.where(role_id: @role.id).first
    @leave.work_from_home == false ? @type = "Leave" : @type = "Work from home"
    @subject = @employee.fullname + " " + "#{@type} request" 
    #mail(to: "srinivas08478@gmail.com", subject: @subject)
    mail(to: @hr.email, subject: @subject)
  end

  def leave_cancel_request_email_to_hr(employee, leave)
    @employee = employee
    @leave = leave
    @role = Role.where(:name=>"HR").first
    @hr = Employee.where(role_id: @role.id).first
    @leave.work_from_home == false ? @type = "Leave" : @type = "Work from home"
    @subject = @employee.fullname + " " + "#{@type} cancel request" 
    #mail(to: "srinivas08478@gmail.com", subject: @subject)
    mail(to: @hr.email, subject: @subject)
  end

  def employee_leave_status(employee, leave)
    @employee = employee
    @leave = leave
    if @leave.status == true
      @status = "Approved"
    else
      @status = "Rejected"
    end
    @leave.work_from_home == false ? @type = "Leave" : @type = "Work from home"
    #mail(to: "srinivas08478@gmail.com", subject: "#{@type} request status")
    mail(to: @employee.email, subject: '#{@type} request status')
  end

  def employee_leave_status_to_hr(employee, leave)
    @employee = employee
    @leave = leave
    @role = Role.where(:name=>"HR").first
    @hr = Employee.where(role_id: @role.id).first
    if @leave.status == true
      @status = "Approved"
    else
      @status = "Rejected"
    end   
    @leave.work_from_home == false ? @type = "Leave" : @type = "Work from home" 
    @subject = @employee.fullname + " " + "#{@type} request status" 
    #mail(to: "srinivas08478@gmail.com", subject: @subject) 
    mail(to: @hr.email, subject: @subject) 
  end

end
