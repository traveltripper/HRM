class CreatePayrolls < ActiveRecord::Migration
  def change
    create_table :payrolls do |t|
      t.integer :employee_id
      t.string :attachment
      t.datetime :pay_date

      t.timestamps null: false
    end
  end
end
