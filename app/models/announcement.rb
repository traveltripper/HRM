class Announcement < ActiveRecord::Base
	belongs_to :employee
	default_scope { order('created_at DESC') }
	extend FriendlyId
	friendly_id :title, use: :slugged
	
	def should_generate_new_friendly_id?
  		title_changed?
	end
end
