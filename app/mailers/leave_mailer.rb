class LeaveMailer < ApplicationMailer

  def employee_leave_request_email(employee, leave)
  	@employee = employee
  	@leave = leave    
    mail(to: @employee.email, subject: 'Leave request')
  end

  def employee_cancel_leave_request_email(employee, leave)
    @employee = employee
    @leave = leave    
    #@email = "srinivas08478@gmail.com"
    #mail(to: @email, subject: 'Leave request cancelled')
    mail(to: @employee.email, subject: 'Leave cancel request')
  end

  def team_leave_request_email(employee, leave)
    @employee = employee
    @leave = leave
    @subject = @employee.fullname + " " + "Leave request" 
    mail(to: @employee.manager.email, subject: @subject)
  end

  def team_cancel_leave_request_email(employee, leave)
    @employee = employee
    @leave = leave
    @subject = @employee.fullname + " " + "Leave cancel request" 
    #@email = "srinivas08478@gmail.com"
    #mail(to: @email, subject: @subject)
    mail(to: @employee.manager.email, subject: @subject)
  end

  def leave_request_email_to_hr(employee, leave)
    @employee = employee
    @leave = leave
    @role = Role.where(:name=>"HR").first
    @hr = Employee.where(role_id: @role.id).first
    @subject = @employee.fullname + " " + "Leave request" 
    mail(to: @hr.email, subject: @subject)
  end

  def leave_cancel_request_email_to_hr(employee, leave)
    @employee = employee
    @leave = leave
    @role = Role.where(:name=>"HR").first
    @hr = Employee.where(role_id: @role.id).first
    @subject = @employee.fullname + " " + "Leave cancel request" 
    #@email = "srinivas08478@gmail.com"
    #mail(to: @email, subject: @subject)
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
    mail(to: @employee.email, subject: 'Leave request status')
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
    @subject = @employee.fullname + " " + "Leave request status" 
    mail(to: @hr.email, subject: @subject) 
  end
end
