class Poll < ActiveRecord::Base
	belongs_to :employee
	belongs_to :pollanswer
	validates_presence_of :employee_id, :pollanswer_id, :pollquestion_id
end
