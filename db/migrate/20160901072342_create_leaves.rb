class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.integer :user_id
      t.datetime :fromdate
      t.datetime :todate
      t.text :reason
      t.boolean :status
      t.integer :no_of_days
      t.integer :leavetype_id

      t.timestamps null: false
    end
  end
end
