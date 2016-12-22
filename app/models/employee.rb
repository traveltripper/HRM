class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  has_many :leave
  belongs_to :role
  has_many :subordinates, class_name: "Employee", foreign_key: "manager_id" 
  belongs_to :manager, class_name: "Employee"
  has_many :payrolls
  has_many :nominations
  validates_presence_of :first_name, :last_name, :role_id, :department_id
  # validates_presence_of :personal_email, :actual_dob, :certificate_dob, :date_of_joining   
  #validates_presence_of :graduation, :source_of_hire, :address
  #validates_presence_of :ttid, :emergency_name, :emergency_contact_no, :health_insurance_card_no, :pf_no, :aadhar_no, :pancard_no, :passport_no
  #validates_presence_of :prev_years_of_exp, :father_or_spouse, :nationality, :date_of_resignation, :lwd
  belongs_to :department
  has_many :polls
  validates_uniqueness_of :ttid
  
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@traveltripper\.com\z/,
                  message: "must be a traveltripper.com account" }

  has_attached_file :profile_picture, styles: { medium: "225x225#", thumb: "100x100!" }, default_url: "/images/no-avatar.jpg"
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\z/
  before_create :set_days_of_leave
  has_many :announcements  
  has_many :healthinsurances
  has_many :events

  scope :ordered_by_first_name, -> { order(first_name: :asc) }

  scope :active, -> { where(status: "Active") }

  def fullname
  	first_name.capitalize.to_s + " " + middle_name.capitalize.to_s + " " + last_name.capitalize.to_s
  end
  
  def emp_birthday    
    custom_date = actual_dob.strftime("%d-%b-") + Time.now.strftime("%y")
    p Date.strptime(custom_date, "%d-%b-%y")    
  end

  def today_birthday
    actual_dob.strftime("%m%d")
  end

  def self.today_month_and_day
    p Time.now.strftime("%m%d")
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|  
      row1 = row.to_hash 
      row2 = {"password"=>"123456" , "password_confirmation"=>"123456"}
      row3 =row1.merge(row2.to_hash)
      p ".........."
      p row3
      p ".........."
           
      Employee.create! row3
    end
  end

  private
    def set_days_of_leave
      self.days_of_leave = ((Time.now.end_of_year - self.date_of_joining)/1.month.second).ceil * 2     
    end

end
