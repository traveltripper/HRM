class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :leaves, :user_id, :employee_id
  end
end
