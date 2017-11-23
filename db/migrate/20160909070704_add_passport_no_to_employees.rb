class AddPassportNoToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :passport_no, :string
  end
end
