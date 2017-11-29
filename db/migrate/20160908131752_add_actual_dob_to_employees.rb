class AddActualDobToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :actual_dob, :datetime
  end
end
