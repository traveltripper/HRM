class ChangeMaritalStatusInEmployees < ActiveRecord::Migration
  def change
  	change_column :employees, :marital_status, :string
  end
end
