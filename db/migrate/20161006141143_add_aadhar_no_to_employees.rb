class AddAadharNoToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :aadhar_no, :string
  end
end
