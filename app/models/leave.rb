class Leave < ActiveRecord::Base
	belongs_to :employee
	belongs_to :leavetype
	validates_presence_of :employee_id, :fromdate, :todate, :reason, :no_of_days, :leavetype_id
	validate :fromdate_must_be_lessthan_todate
	
	
	def fromdate_must_be_lessthan_todate
  		return if fromdate.blank? || todate.blank?

	  	if todate < fromdate
	    	errors.add(:todate, "cannot be before the from date") 
	  	end 
	end

	def caliculate_no_of_days
		#p fromdate = fromdate.beginning_of_day
		#p todate = todate.end_of_day
		#((todate - fromdate)/86400).to_i
	end
end