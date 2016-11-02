class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :events, :end, :end_date
  end
end
