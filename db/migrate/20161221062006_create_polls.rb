class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.integer :employee_id
      t.integer :pollanswer_id
      t.integer :pollquestion_id

      t.timestamps null: false
    end
  end
end
