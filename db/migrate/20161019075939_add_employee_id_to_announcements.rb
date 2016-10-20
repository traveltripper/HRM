class AddEmployeeIdToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :employee_id, :integer
  end
end
