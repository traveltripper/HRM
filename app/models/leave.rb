class Leave < ActiveRecord::Base
	self.table_name = "leaves"
	belongs_to :employee
	belongs_to :leavetype
	validates_presence_of :employee_id, :fromdate, :todate, :reason, :leavetype_id
	validate :fromdate_must_be_lessthan_todate
	default_scope { order('created_at DESC') }	
	after_create :send_emails
	def fromdate_must_be_lessthan_todate
  		return if fromdate.blank? || todate.blank?

	  	if todate < fromdate
	  		errors.add(:todate, "cannot be before the from date")
	  	else
	    	 p "testing"
	  	end 
	end

	private

	def send_emails		
		# @leave = Leave.find(id) 
		# @employee = @leave.employee 
  #   	LeaveMailer.employee_leave_request_email(@emp, @leave).deliver_later
  #   	LeaveMailer.team_leave_request_email(@emp, @leave).deliver_later
  #   	LeaveMailer.leave_request_email_to_hr(@emp, @leave).deliver_later
	end
	

	# def no_of_days
	# 	("#{fromdate.to_date} - #{todate.to_date}").to_i + 1
	# end	
end