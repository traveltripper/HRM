class EventMailer < ApplicationMailer	
	def send_event_email_to_all_employees(event)
		@emails = Employee.all.collect(&:email).join(",")
		@event = event
		mail(to: @emails, subject: 'A new event has been posted in HRM')
	end

	def send_event_email_to_team(event, employee)
		@emails = employee.subordinates.collect(&:email).join(",")
		@event = event
		mail(to: @emails, subject: 'A new team event has been posted in HRM')
	end
end
