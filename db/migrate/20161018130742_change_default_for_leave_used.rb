class ChangeDefaultForLeaveUsed < ActiveRecord::Migration
  def change
  	change_column :employees, :leave_used, :integer, :default => 0
  end
end
