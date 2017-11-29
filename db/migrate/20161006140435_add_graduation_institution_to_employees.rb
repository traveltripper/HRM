class AddGraduationInstitutionToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :graduation_institution, :string
  end
end
