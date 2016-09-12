class AddLwdToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :lwd, :datetime
  end
end
