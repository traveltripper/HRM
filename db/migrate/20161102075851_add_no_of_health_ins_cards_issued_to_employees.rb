class AddNoOfHealthInsCardsIssuedToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :no_of_health_ins_cards_issued, :string
  end
end
