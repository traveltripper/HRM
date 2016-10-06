class AddMaritalStatusToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :marital_status, :boolean
  end
end
