class Pollanswer < ActiveRecord::Base
	belongs_to :pollquestion
	has_many :poll, :foreign_key => "pollanswer_id"
end
