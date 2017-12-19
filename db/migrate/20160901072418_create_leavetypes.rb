class CreateLeavetypes < ActiveRecord::Migration
  def change
    create_table :leavetypes do |t|
      t.string :name
      t.integer :limit, :default => 0

      t.timestamps null: false
    end
  end
end
