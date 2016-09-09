class AddSourceOfHireToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :source_of_hire, :string
  end
end
