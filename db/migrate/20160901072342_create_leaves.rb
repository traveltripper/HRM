class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.integer :employee_id
      t.datetime :fromdate
      t.datetime :todate
      t.text :reason
      t.boolean :status
      t.integer :no_of_days
      t.integer :leavetype_id
      t.integer :leave_balance
      t.text :reject_reason
      t.boolean :leave_cancel, default: false
      t.boolean :work_from_home, default: false

      t.timestamps null: false
    end
  end
end
