class AddPgInstitutionToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :pg_institution, :string
  end
end
