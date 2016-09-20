class LeaveMailer < ApplicationMailer

  def employee_leave_request_email(employee, leave)
  	@employee = employee
  	@leave = leave
  	p "........"
  	p @employee.email
  	p "........."
    @email = "srinivas08478@gmail.com"
    mail(to: @email, subject: 'Leave request')
  end

end
