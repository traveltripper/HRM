class AddEmergencyNameToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :emergency_name, :string
  end
end
