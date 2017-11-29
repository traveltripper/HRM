class AddActiveToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :active, :boolean, :default => true
  end
end
