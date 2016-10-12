class Ability
  include CanCan::Ability

  def initialize(employee)
    employee ||= Employee.new
    if employee.role.name == "HR"
        can :manage, :all        
    else
        cannot :read, Role
        cannot :read, Department
        cannot :read, Leavetype
        can :read, Employee
    end
    
  end
end
