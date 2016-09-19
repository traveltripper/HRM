# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Employee.create(first_name: "Travel1", last_name: "tripper1", email: "1@gmail.com", manager_id: 11, role_id: 1)
# Employee.create(first_name: "Travel2", last_name: "tripper2", email: "2@gmail.com", manager_id: 11, role_id: 1)
# Employee.create(first_name: "Travel3", last_name: "tripper3", email: "3@gmail.com", manager_id: 11, role_id: 1)
# Employee.create(first_name: "Travel4", last_name: "tripper4", email: "4@gmail.com", manager_id: 11, role_id: 1)
# Employee.create(first_name: "Travel5", last_name: "tripper5", email: "5@gmail.com", manager_id: 11, role_id: 1)
# Employee.create(first_name: "Travel6", last_name: "tripper6", email: "6@gmail.com", manager_id: 11, role_id: 1)
# Employee.create(first_name: "Travel7", last_name: "tripper7", email: "7@gmail.com", manager_id: 11, role_id: 1)
# Employee.create(first_name: "Travel8", last_name: "tripper8", email: "8@gmail.com", manager_id: 11, role_id: 1)
# Employee.create(first_name: "Travel9", last_name: "tripper9", email: "9@gmail.com", manager_id: 11, role_id: 1)
# Employee.create(first_name: "Travel10", last_name: "tripper10", email: "10@gmail.com", manager_id: 11, role_id: 1)
# Employee.create(first_name: "Travel11", last_name: "tripper11", email: "11@gmail.com", role_id: 3)


# Leave.create(employee_id: 1, fromdate: "2016-09-01 05:53:09", todate: "2016-09-02 05:53:09", reason: "text1", status: false, no_of_days: 2, leavetype_id: 2) 
# Leave.create(employee_id: 2, fromdate: "2016-09-01 05:53:09", todate: "2016-09-03 05:53:09", reason: "text2", status: false, no_of_days: 3, leavetype_id: 3) 
# Leave.create(employee_id: 3, fromdate: "2016-09-01 05:53:09", todate: "2016-09-01 05:53:09", reason: "text3", status: false, no_of_days: 1, leavetype_id: 1) 
# Leave.create(employee_id: 4, fromdate: "2016-09-01 05:53:09", todate: "2016-09-04 05:53:09", reason: "text4", status: false, no_of_days: 4, leavetype_id: 4) 
# Leave.create(employee_id: 5, fromdate: "2016-09-01 05:53:09", todate: "2016-09-05 05:53:09", reason: "text5", status: false, no_of_days: 5, leavetype_id: 1) 
# Leave.create(employee_id: 6, fromdate: "2016-09-01 05:53:09", todate: "2016-09-02 05:53:09", reason: "text6", status: false, no_of_days: 2, leavetype_id: 2) 
# Leave.create(employee_id: 7, fromdate: "2016-09-01 05:53:09", todate: "2016-09-03 05:53:09", reason: "text7", status: false, no_of_days: 3, leavetype_id: 3) 
# Leave.create(employee_id: 8, fromdate: "2016-09-01 05:53:09", todate: "2016-09-03 05:53:09", reason: "text8", status: false, no_of_days: 3, leavetype_id: 4) 
# Leave.create(employee_id: 9, fromdate: "2016-09-01 05:53:09", todate: "2016-09-01 05:53:09", reason: "text9", status: false, no_of_days: 1, leavetype_id: 1) 


Leavetype.create(name: "FMLA")
Leavetype.create(name: "Maternity")
Leavetype.create(name: "Paternity")
Leavetype.create(name: "Vacation")


Role.create(name: "Employee")
Role.create(name: "HR")
Role.create(name: "S.Manager")
Role.create(name: "Finace")


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')