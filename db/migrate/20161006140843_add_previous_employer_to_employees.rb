class AddPreviousEmployerToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :previous_employer, :string
  end
end
