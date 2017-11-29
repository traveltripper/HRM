class CreateConferenceRooms < ActiveRecord::Migration
  def change
    create_table :conference_rooms do |t|
      t.string :name
      t.boolean :available

      t.timestamps null: false
    end
  end
end
