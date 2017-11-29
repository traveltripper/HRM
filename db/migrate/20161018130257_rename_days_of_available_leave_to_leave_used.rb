class RenameDaysOfAvailableLeaveToLeaveUsed < ActiveRecord::Migration
  def change
  	rename_column :employees, :days_of_available_leave, :leave_used
  end
end
