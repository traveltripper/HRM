class Payroll < ActiveRecord::Base
	mount_uploader :attachment, AttachmentUploader
	belongs_to :employee

	

end
