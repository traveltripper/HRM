ActiveAdmin.register Employee do

	permit_params :email, :password, :password_confirmation, :first_name, :last_name, :manager_id, :role_id, :phone

	index do
	  id_column
	  column :first_name
	  column :last_name
	  column :manager_id do |e|     
	    if e.manager_id
        Employee.find(e.manager_id).first_name
    	else
    		p "nil"
    	end    	
	  end
	  column :role_id
	  column :email
	  column :phone
	  actions
	end

	form do |f|
		f.inputs "Admin Details" do
		  f.input :first_name
		  f.input :last_name
		  f.input :manager_id
		  f.input :role_id
		  f.input :email
		  f.input :phone
		  if f.object.new_record?
		  	f.input :password
		  	f.input :password_confirmation
		  end
		end
		f.actions
	end
end
