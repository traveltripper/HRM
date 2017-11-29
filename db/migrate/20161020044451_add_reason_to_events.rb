class AddReasonToEvents < ActiveRecord::Migration
  def change
    add_column :events, :reason, :text
  end
end
