class AddLeaveCountToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :leave_count, :integer
  end
end
