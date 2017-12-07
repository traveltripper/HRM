class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start
      t.datetime :end_date
      t.text :reason
      t.integer :employee_id
      t.boolean :publish, default: true
      t.string :slug, unique: true

      t.timestamps null: false
    end
  end
end
