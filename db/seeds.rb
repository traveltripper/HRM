# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Role.create(name: "Employee")
Role.create(name: "Manager")
Role.create(name: "HR")
Role.create(name: "Finace")

Department.create(name: "IT")
Department.create(name: "ROR")
Department.create(name: "JAVA")
Department.create(name: "CS")
Department.create(name: "Finance")
Department.create(name: "Human Resources")
Department.create(name: "Support")

Leavetype.create(name: "Sick")
Leavetype.create(name: "Maternity")
Leavetype.create(name: "Paternity")
Leavetype.create(name: "Vacation")


# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
Employee.create!(first_name: "hrtest", middle_name: "hrtest", last_name: "hrtest", manager_id: 1, role_id: 3, department_id: 1, ttid: "100", email: "hrmtest@traveltripper.com", personal_email: "hrtestp@tt.com", contact_no: "123456", emergency_name: "test", emergency_contact_no: "123456789", designation: "HR", actual_dob: DateTime.strptime('09/14/2009', '%m/%d/%Y'), certificate_dob: DateTime.strptime('09/14/2009', '%m/%d/%Y'), doj: DateTime.strptime('09/14/2009', '%m/%d/%Y'), prev_years_of_exp: 5, pg: "test", graduation: "test", source_of_hire: "Direct", pancard_no: "12356", passport_no: "123456", status: "Active", lwd: DateTime.strptime('09/14/2009', '%m/%d/%Y'), date_of_joining: DateTime.strptime('09/14/2016', '%m/%d/%Y'), date_of_resignation: DateTime.strptime('09/14/2009', '%m/%d/%Y'), address: "test", password: "123456", password_confirmation: "123456")
