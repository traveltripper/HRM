class AddLeaveCancelToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :leave_cancel, :boolean, default: false
  end
end
