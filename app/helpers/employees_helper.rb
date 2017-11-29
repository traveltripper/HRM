module EmployeesHelper

	def all_managers(id)		
    	emp_mng =  Employee.find(id)        
        if emp_mng.manager
    		if emp_mng.manager.email == "traveltripperhrm@traveltripper.com"
    			@subordinates << [ {:v => "#{emp_mng.fullname}" , :f => "#{emp_mng.fullname}<div style='color:red; font-style:italic'>#{emp_mng.designation}<div>"}, "", emp_mng.fullname  ]
    		else
    			@subordinates << [ {:v => "#{emp_mng.fullname}" , :f => "#{emp_mng.fullname}<div style='color:red; font-style:italic'>#{emp_mng.designation}<div>"}, emp_mng.manager.fullname, emp_mng.fullname  ]
    			all_managers(emp_mng.manager.id)
    		end
        end 
	end

	# def all_subordinates(id)
	# 	emp_subs =  Employee.find(id)
	# 		unless emp_subs.subordinates.blank?
	# 			@emp_subs.subordinates.each do |f|
    #      			@subordinates << [ f.fullname  , @emp_subs.fullname]
    #      			all_subordinates(f.id)
    #    		end
	# 	end
	# end
end



