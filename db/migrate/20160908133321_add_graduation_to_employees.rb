class AddGraduationToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :graduation, :string
  end
end
