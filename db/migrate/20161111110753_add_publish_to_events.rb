class AddPublishToEvents < ActiveRecord::Migration
  def change
    add_column :events, :publish, :boolean, default: true
  end
end
