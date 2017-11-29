class CreatePollanswers < ActiveRecord::Migration
  def change
    create_table :pollanswers do |t|
      t.integer :pollquestion_id
      t.string :option
      t.boolean :status

      t.timestamps null: false
    end
  end
end
