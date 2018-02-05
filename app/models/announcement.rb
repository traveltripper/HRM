class Announcement < ActiveRecord::Base
	belongs_to :employee
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing.jpg"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
	default_scope { order('created_at DESC') }
	scope :active, -> {where(active: true)}
	extend FriendlyId
	friendly_id :title, use: :slugged
	
	def should_generate_new_friendly_id?
  		title_changed?
	end
end
