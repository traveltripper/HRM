class Ability
  include CanCan::Ability

  def initialize(employee)
    employee ||= Employee.new
    if employee.role.name == "HR"
        can :manage, :all 
    elsif employee.role.name == "Finance"
        can :manage, Payroll        
    else
        cannot :read, Role
        cannot :read, Department
        cannot :read, Leavetype
        can :read, Employee
        can :read, Payroll
    end
    
  end
end
