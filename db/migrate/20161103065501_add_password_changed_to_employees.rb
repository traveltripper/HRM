class AddPasswordChangedToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :password_changed, :boolean
  end
end
