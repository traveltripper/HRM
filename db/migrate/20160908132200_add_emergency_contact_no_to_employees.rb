class AddEmergencyContactNoToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :emergency_contact_no, :string
  end
end
