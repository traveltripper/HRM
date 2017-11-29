class AddWorkFromHomeUsedToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :work_from_home_used, :integer, :default => 0
  end
end
