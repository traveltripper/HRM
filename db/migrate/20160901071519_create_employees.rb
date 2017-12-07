class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.integer :manager_id
      t.integer :role_id
      t.string :phone
      t.string :middle_name
      t.string  :ttid
      t.string :personal_email
      t.string :contact_no
      t.datetime :actual_dob
      t.datetime :certificate_dob
      t.string :emergency_name
      t.string :emergency_contact_no
      t.integer :prev_years_of_exp
      t.datetime :doj
      t.string :pg
      t.string :graduation
      t.text :address
      t.string :source_of_hire
      t.integer :department_id
      t.string :status
      t.datetime :lwd
      t.datetime :date_of_resignation
      t.string :nationality
      t.string :blood_group
      t.string :marital_status
      t.string :graduation_institution
      t.string :graduation_university
      t.string :pg_university
      t.string :pg_institution
      t.string :previous_employer
      t.string :pf_no
      t.string :aadhar_no
      t.text :current_address
      t.string :father_or_spouse
      t.string :health_insurance_card_no
      t.datetime :date_of_joining
      t.integer :days_of_leave
      t.boolean :password_changed
      t.string :no_of_health_ins_cards_issued
      t.text :about_me
      t.string :designation
      t.string :skype_id
      t.integer :leave_used, :default => 0
      t.integer :work_from_home_used, :default => 0
      t.boolean :welcome_email_sent, :default: false
      t.boolean :password_changed
      t.integer :days_of_available_leave
      t.string :previous_employer
      t.string :passport_no
      t.string :pancard_no

      t.timestamps null: false
    end
  end
end
