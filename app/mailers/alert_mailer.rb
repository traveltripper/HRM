class AlertMailer < ApplicationMailer

	def alert_to_particular_emails(emails, subject, message)
		@emails = emails
		@subject = subject
		@message = message
		mail(to: @emails, subject: @subject)
	end

	def entire_team
	end

	def all_employees
	end
end
