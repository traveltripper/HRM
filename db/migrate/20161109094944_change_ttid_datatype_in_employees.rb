class ChangeTtidDatatypeInEmployees < ActiveRecord::Migration
  def change
  	change_column :employees, :ttid, :string
  end  
end
