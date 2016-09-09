class AddContactNoToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :contact_no, :string
  end
end
