class Cpp < ActiveRecord::Base
	self.table_name = "cpps"
	extend FriendlyId
	friendly_id :designation
end
