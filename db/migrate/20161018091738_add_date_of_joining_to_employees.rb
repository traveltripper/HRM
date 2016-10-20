class AddDateOfJoiningToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :date_of_joining, :datetime
  end
end
