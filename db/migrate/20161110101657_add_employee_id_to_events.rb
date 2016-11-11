class AddEmployeeIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :employee_id, :integer
  end
end
