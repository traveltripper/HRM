class AddPrevYearsOfExpToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :prev_years_of_exp, :integer
  end
end
