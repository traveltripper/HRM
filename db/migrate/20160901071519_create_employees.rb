class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.integer :manager_id
      t.integer :role_id

      t.timestamps null: false
    end
  end
end
