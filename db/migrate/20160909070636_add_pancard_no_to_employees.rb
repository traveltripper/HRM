class AddPancardNoToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :pancard_no, :string
  end
end
