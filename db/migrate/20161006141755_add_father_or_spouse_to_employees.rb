class AddFatherOrSpouseToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :father_or_spouse, :string
  end
end
