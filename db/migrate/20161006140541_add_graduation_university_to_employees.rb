class AddGraduationUniversityToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :graduation_university, :string
  end
end
