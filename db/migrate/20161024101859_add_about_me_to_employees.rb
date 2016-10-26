class AddAboutMeToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :about_me, :text
  end
end
