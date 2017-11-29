class CreateHealthinsurances < ActiveRecord::Migration
  def change
    create_table :healthinsurances do |t|
      t.string :name
      t.string :card_number
      t.string :relation
      t.datetime :issued_date
      t.datetime :policy_start_date
      t.datetime :policy_end_date
      t.integer :employee_id

      t.timestamps null: false
    end
  end
end
