class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  has_many :leave
  belongs_to :role
  has_many :subordinates, class_name: "Employee", foreign_key: "manager_id" 
  belongs_to :manager, class_name: "Employee"
  validates_presence_of :first_name, :last_name, :middle_name, :role_id, :department_id, :ttid, :personal_email, :contact_no, :emergency_name, :emergency_contact_no, :actual_dob, :certificate_dob, :doj 
  validates_presence_of :graduation, :pg, :source_of_hire, :address, :blood_group
  validates_presence_of :health_insurance_card_no, :pf_no, :aadhar_no, :pancard_no, :passport_no
  validates_presence_of :previous_employer, :prev_years_of_exp, :father_or_spouse, :nationality, :date_of_resignation, :lwd
  belongs_to :department
  # acts_as_birthday :crated_at
  #acts_as_birthday :actual_dob
  
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@traveltripper\.com\z/,
                  message: "must be a traveltripper.com account" }
  
  def fullname
  	first_name.capitalize.to_s + " " + middle_name.capitalize.to_s + " " + last_name.capitalize.to_s
  end
  
  def emp_birthday    
    custom_date = actual_dob.strftime("%d-%b-") + Time.now.strftime("%y")
    p Date.strptime(custom_date, "%d-%b-%y")    
  end

end
