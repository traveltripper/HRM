class AddRejectReasonToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :reject_reason, :text
  end
end
