class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :message
      t.integer :employee_id
      t.string :slug, unique: true
	    t.boolean :active, :default => true

      t.timestamps null: false
    end
  end
end
