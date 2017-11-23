class EmployeeMailer < ApplicationMailer
	def welcome_email(employee, password)
		@employee = employee
		@password = password
    	mail(to: @employee.email, subject: 'Welcome to Travel Tripper HRM Tool')
	end
end
