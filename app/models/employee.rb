class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  has_many :leave
  belongs_to :role
  has_many :subordinates, class_name: "Employee", foreign_key: "manager_id" 
  belongs_to :manager, class_name: "Employee"
  validates_presence_of :first_name, :last_name, :role_id, :department_id, :ttid, :personal_email, :contact_no, :emergency_name, :emergency_contact_no, :actual_dob, :certificate_dob, :doj 
  validates_presence_of :graduation, :source_of_hire, :pancard_no, :passport_no, :status, :address
  belongs_to :department

  def fullname
  	first_name.to_s + " " + middle_name.to_s + " " + last_name.to_s
  end

end
