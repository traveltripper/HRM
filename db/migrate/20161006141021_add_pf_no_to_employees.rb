class AddPfNoToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :pf_no, :string
  end
end
