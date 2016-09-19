ActiveAdmin.register Leave do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
permit_params :employee_id, :fromdate, :todate, :reason, :status, :no_of_days, :leavetype_id

index do
  id_column
  column :employee_id do |f|
    if Employee.find_by_id(f.employee_id)
  	  Employee.find_by_id(f.employee_id).first_name
    end
  end
  column :fromdate do |r|
	r.fromdate.strftime('%Y-%b-%d')
	  end
  column :todate do |f|
  	f.todate.strftime('%Y-%b-%d')
  end
  column :reason
  column :status
  column :no_of_days
  column :leavetype_id 
  actions
end

show do
    attributes_table do
      row :employee_id do |f|
        if Employee.find_by_id(f.employee_id)
  		    Employee.find(f.employee_id).first_name
        end
  	  end
	  row :fromdate do |r|
    	r.fromdate.strftime('%Y-%b-%d')
  	  end
	  row :todate do |f|
	  	f.todate.strftime('%Y-%b-%d')
	  end
	  row :reason
	  row :status
	  row :no_of_days
	  row :leavetype_id
    end
end

form do |f|
	f.inputs "Leave Details" do
	  f.input :employee_id
	  f.input :fromdate, :as => :datepicker
	  f.input :todate, :as => :datepicker
	  f.input :reason
	  f.input :status
	  f.input :no_of_days
	  f.input :leavetype_id, label: "leavetype", as: :select, collection: Leavetype.all.map{|u| [u.name, u.id]}, prompt: "Select Leavetype"
  	end
	f.actions
end

end
