class CreateCpps < ActiveRecord::Migration
  def change
    create_table :cpps do |t|
      t.text :description
      t.string :designation
      
      t.timestamps null: false
    end
  end
end
