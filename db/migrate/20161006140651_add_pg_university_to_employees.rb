class AddPgUniversityToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :pg_university, :string
  end
end
