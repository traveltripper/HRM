class AddDesignationToCpp < ActiveRecord::Migration
  def change
    add_column :cpps, :designation, :string
  end
end
