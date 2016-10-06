class Department < ActiveRecord::Base
	has_many :employees
    #scope :manager, -> { employees.order(name: :asc) }
    
	# def employees
	# 	Employee.where(:manager_id => nil)
	# end

end


