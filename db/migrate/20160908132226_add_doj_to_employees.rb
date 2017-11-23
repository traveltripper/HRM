class AddDojToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :doj, :datetime
  end
end
