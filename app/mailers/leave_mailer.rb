class LeaveMailer < ApplicationMailer

  def employee_leave_request_email(employee, leave)
  	@employee = employee
  	@leave = leave
    @email = "srinivas08478@gmail.com"
    mail(to: @email, subject: 'Leave request')
  end

  def team_leave_request_email(employee, leave)
    @employee = employee
    @leave = leave
    @email = "srinivas08478@gmail.com"
    @subject = @employee.fullname + " " + "Leave request" 
    mail(to: @email, subject: @subject)
  end

  def leave_request_email_to_hr(employee, leave)
    @employee = employee
    @leave = leave
    @hr = Employee.where(:role_id => 2).first
    @email = "srinivas08478@gmail.com"
    @subject = @employee.fullname + " " + "Leave request" 
    mail(to: @email, subject: @subject)
  end

  def employee_leave_status(employee, leave)
    @employee = employee
    @leave = leave
    if @leave.status == true
      @status = "Approved"
    else
      @status = "Rejected"
    end
    @email = "srinivas08478@gmail.com"
    mail(to: @email, subject: 'Leave request status', :cc => "nsangana@traveltripper.com")
  end

  def employee_leave_status_to_hr(employee, leave)
    @employee = employee
    @leave = leave
    @hr = Employee.where(:role_id => 2).first
    if @leave.status == true
      @status = "Approved"
    else
      @status = "Rejected"
    end
    @email = "srinivas08478@gmail.com"
    @subject = @employee.fullname + " " + "Leave request status" 
    mail(to: @email, subject: @subject, :cc => "nsangana@traveltripper.com")
  end
end
