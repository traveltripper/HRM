class AddPgToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :pg, :string
  end
end
