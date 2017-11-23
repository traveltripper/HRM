class Leave < ActiveRecord::Base
	self.table_name = "leaves"
	belongs_to :employee
	belongs_to :leavetype
	validates_presence_of :employee_id, :fromdate, :todate, :reason
	validate :fromdate_must_be_lessthan_todate
	#validate :days_greater_than_zero
	default_scope { order('created_at DESC') }	
	#after_create :send_emails
	def fromdate_must_be_lessthan_todate
  		return if fromdate.blank? || todate.blank?

	  	if todate < fromdate
	  		errors.add(:todate, "cannot be before the from date")	  	
	  	end 
	end

	def can_cancel_leave
		p fromdate
	end

	def days_greater_than_zero
		if (todate - fromdate) == 0
			errors.add(:todate, "Days should be greater than 0")
		end 
	end

	private

	# def no_of_days
	# 	("#{fromdate.to_date} - #{todate.to_date}").to_i + 1
	# end	
end