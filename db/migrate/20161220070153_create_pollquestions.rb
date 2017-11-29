class CreatePollquestions < ActiveRecord::Migration
  def change
    create_table :pollquestions do |t|
      t.text :question
      t.boolean :status

      t.timestamps null: false
    end
  end
end
