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
Role.create(name: "Admin")

Department.create(name: "Admin")
Department.create(name: "TT Web")
Department.create(name: "TT Agency")
Department.create(name: "ROR Booking Engine")
Department.create(name: "Product")
Department.create(name: "Support")
Department.create(name: "Testing")
Department.create(name: "Java Booking Engine")
Department.create(name: "Client Services")
Department.create(name: "Hotel Trader")
Department.create(name: "Project Management")

Leavetype.create(name: "Sick", limit: 6)
Leavetype.create(name: "Casual/Privilege", limit: 24)
Leavetype.create(name: "Maternity", limit: 180)
Leavetype.create(name: "Paternity", limit: 5)

Employee.create!(first_name: "admin", middle_name: "", last_name: "traveltripper", role_id: 4, department_id: 1, ttid: "ttadmin0", email: "traveltripperhrm0@traveltripper.com", personal_email: "admin@tt.com", contact_no: "123456789", emergency_name: "test", emergency_contact_no: "123456789", designation: "Admin", actual_dob: DateTime.strptime('08/26/1990', '%m/%d/%Y'), certificate_dob: DateTime.strptime('08/26/1990', '%m/%d/%Y'), prev_years_of_exp: 5, pg: "test", graduation: "test", source_of_hire: "Direct", pancard_no: "12356", passport_no: "123456", status: "Active", date_of_joining: DateTime.strptime('09/14/2016', '%m/%d/%Y'), address: "test", password: "123456", password_confirmation: "123456")
Employee.create!(first_name: "hr", middle_name: "", last_name: "traveltripper", role_id: 3, department_id: 5, ttid: "ttadmin1", email: "traveltripperhrm1@traveltripper.com", personal_email: "admin@tt.com", contact_no: "123456789", emergency_name: "test", emergency_contact_no: "123456789", designation: "Admin", actual_dob: DateTime.strptime('08/26/1990', '%m/%d/%Y'), certificate_dob: DateTime.strptime('08/26/1990', '%m/%d/%Y'), prev_years_of_exp: 5, pg: "test", graduation: "test", source_of_hire: "Direct", pancard_no: "12356", passport_no: "123456", status: "Active", date_of_joining: DateTime.strptime('09/14/2016', '%m/%d/%Y'), address: "test", password: "123456", password_confirmation: "123456")
Employee.create!(first_name: "manager", middle_name: "", last_name: "traveltripper", role_id: 2, department_id: 5, ttid: "ttadmin2", email: "traveltripperhrm2@traveltripper.com", personal_email: "admin@tt.com", contact_no: "123456789", emergency_name: "test", emergency_contact_no: "123456789", designation: "Admin", actual_dob: DateTime.strptime('08/26/1990', '%m/%d/%Y'), certificate_dob: DateTime.strptime('08/26/1990', '%m/%d/%Y'), prev_years_of_exp: 5, pg: "test", graduation: "test", source_of_hire: "Direct", pancard_no: "12356", passport_no: "123456", status: "Active", date_of_joining: DateTime.strptime('09/14/2016', '%m/%d/%Y'), address: "test", password: "123456", password_confirmation: "123456")
Employee.create!(first_name: "employee", middle_name: "", last_name: "traveltripper", role_id: 1, department_id: 2, ttid: "ttadmin3", email: "traveltripperhrm3@traveltripper.com", personal_email: "admin@tt.com", contact_no: "123456789", emergency_name: "test", emergency_contact_no: "123456789", designation: "Admin", actual_dob: DateTime.strptime('08/26/1990', '%m/%d/%Y'), certificate_dob: DateTime.strptime('08/26/1990', '%m/%d/%Y'), prev_years_of_exp: 5, pg: "test", graduation: "test", source_of_hire: "Direct", pancard_no: "12356", passport_no: "123456", status: "Active", date_of_joining: DateTime.strptime('09/14/2016', '%m/%d/%Y'), address: "test", password: "123456", password_confirmation: "123456")
