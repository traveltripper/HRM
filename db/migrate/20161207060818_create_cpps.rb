class CreateCpps < ActiveRecord::Migration
  def change
    create_table :cpps do |t|
      t.text :description

      t.timestamps null: false
    end
  end
end
