class AddLeaveBalanceToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :leave_balance, :integer
  end
end
