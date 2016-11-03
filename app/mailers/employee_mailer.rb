class EmployeeMailer < ApplicationMailer
	def welcome_email
		@employee = Employee.last
		@email = "srinivas08478@gmail.com"
    	mail(to: @email, subject: 'Welcome to Travel Tripper HRM Tool')
	end
end
