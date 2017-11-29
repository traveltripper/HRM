class AddCertificateDobToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :certificate_dob, :datetime
  end
end
