class AddWelcomeEmailSentToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :welcome_email_sent, :boolean, default: false
  end
end
