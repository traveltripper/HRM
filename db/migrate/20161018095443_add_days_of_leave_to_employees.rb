class AddDaysOfLeaveToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :days_of_leave, :integer
  end
end
