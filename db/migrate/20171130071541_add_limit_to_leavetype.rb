class AddLimitToLeavetype < ActiveRecord::Migration
  def change
    add_column :leavetypes, :limit, :integer
  end
end
