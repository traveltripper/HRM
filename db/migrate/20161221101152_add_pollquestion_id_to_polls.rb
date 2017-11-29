class AddPollquestionIdToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :pollquestion_id, :integer
  end
end
