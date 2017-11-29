class AddWorkFromHomeToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :work_from_home, :boolean, default: false
  end
end
