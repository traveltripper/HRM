class CreateNominations < ActiveRecord::Migration
  def change
    create_table :nominations do |t|
      t.string :type
      t.string :name
      t.integer :employee_id

      t.timestamps null: false
    end
  end
end
