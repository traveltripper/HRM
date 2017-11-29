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
Role.create(name: "Admin")

Department.create(name: "Admin")

# Leavetype.create(name: "Sick")
# Leavetype.create(name: "Maternity")
# Leavetype.create(name: "Paternity")
# Leavetype.create(name: "Vacation")


Employee.create!(first_name: "admin", middle_name: "", last_name: "traveltripper", role_id: 5, department_id: 1, ttid: "ttadmin1", email: "traveltripperhrm@traveltripper.com", personal_email: "admin@tt.com", contact_no: "123456789", emergency_name: "test", emergency_contact_no: "123456789", designation: "Admin", actual_dob: DateTime.strptime('08/26/1990', '%m/%d/%Y'), certificate_dob: DateTime.strptime('08/26/1990', '%m/%d/%Y'), prev_years_of_exp: 5, pg: "test", graduation: "test", source_of_hire: "Direct", pancard_no: "12356", passport_no: "123456", status: "Active", date_of_joining: DateTime.strptime('09/14/2016', '%m/%d/%Y'), address: "test", password: "123456", password_confirmation: "123456")