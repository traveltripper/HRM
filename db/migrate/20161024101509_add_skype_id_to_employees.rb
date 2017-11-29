class AddSkypeIdToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :skype_id, :string
  end
end
