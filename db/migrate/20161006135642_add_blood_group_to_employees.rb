class AddBloodGroupToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :blood_group, :string
  end
end
