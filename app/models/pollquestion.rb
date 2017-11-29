class Pollquestion < ActiveRecord::Base
	has_many :pollanswers, :foreign_key => "pollquestion_id"
	accepts_nested_attributes_for :pollanswers, reject_if: :all_blank, allow_destroy: true
	#accepts_nested_attributes_for :pollanswers

 #    def task_attributes=(task_attributes)
 #  		task_attributes.each do |attributes|
 #    		pollanswers.build(attributes)
 #  		end
	# end
end
