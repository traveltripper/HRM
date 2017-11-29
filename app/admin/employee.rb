ActiveAdmin.register Employee do

	permit_params :email, :password, :password_confirmation, :first_name, :last_name, :manager_id, :role_id, :phone

	index do
	  id_column
	  column :first_name
	  column :last_name
	  column :manager_id do |e|     
	    if Employee.find_by_id(e.manager_id) 
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

	show do
	    attributes_table do
	      row :first_name
	      row :last_name
	      row :manager_id
	      row :role_id
	      row :email
	      row :phone
	    end
    end

	form do |f|
		f.inputs "Employee Details" do
		  f.input :first_name
		  f.input :last_name
		  f.input :manager_id, label: "Manager id", as: :select, collection: Employee.where(manager_id: nil).map{|u| [u.first_name, u.id]}, prompt: "Select Manager" 
		  f.input :role_id, label: "Role id", as: :select, collection: Role.all.map{|u| [u.name, u.id]}, prompt: "Select Role"
		  f.input :email
		  f.input :phone
		  if f.object.new_record?
		  	f.input :password
		  	f.input :password_confirmation
		  end
		end
		f.actions
	end

	def self.mangerlist
		Employee.where(manager_id: nil).first_name
	end
end
