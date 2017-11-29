class AddNationalityToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :nationality, :string
  end
end
