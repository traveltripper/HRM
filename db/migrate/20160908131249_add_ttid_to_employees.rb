class AddTtidToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :ttid, :integer
  end
end
