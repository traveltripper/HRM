class AddDateOfResignationToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :date_of_resignation, :datetime
  end
end
