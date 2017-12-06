class Leavetype < ActiveRecord::Base
	has_many :leave
	validates_presence_of :name
	validates :limit, numericality: { only_integer: true }
end
