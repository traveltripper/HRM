class AddCurrentAddressToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :current_address, :text
  end
end
