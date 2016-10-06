class AddHealthInsuranceCardNoToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :health_insurance_card_no, :string
  end
end
