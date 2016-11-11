class Ability
  include CanCan::Ability

  def initialize(employee)
    employee ||= Employee.new
    if employee.role.name.in?(['HR', 'Admin'])
        can :manage, :all 
    elsif employee.role.name == "Finance"
        can :manage, Payroll     
    elsif employee.role.name == "Manager" 
        can :manage, Event   
    else
        cannot :read, Role
        cannot :read, Department
        cannot :read, Leavetype
        can :read, Employee
        can :read, Payroll
        can :read, Event
        can :read, Announcement
    end
    
  end
end
