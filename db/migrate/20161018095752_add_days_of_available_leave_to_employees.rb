class AddDaysOfAvailableLeaveToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :days_of_available_leave, :integer
  end
end
