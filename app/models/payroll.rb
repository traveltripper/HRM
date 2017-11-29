class Payroll < ActiveRecord::Base
	mount_uploader :attachment, AttachmentUploader
	belongs_to :employee
	default_scope { order('created_at DESC') }
end
