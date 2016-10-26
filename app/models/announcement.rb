class Announcement < ActiveRecord::Base
	belongs_to :employee
	default_scope { order('created_at DESC') }
end
