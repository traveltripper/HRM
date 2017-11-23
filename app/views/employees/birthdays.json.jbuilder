json.array! @employees do |employee|

  json.id employee.id
  json.fullname employee.fullname
  json.ttid employee.ttid
  json.department employee.department.name
  json.role employee.role.name
  json.start employee.emp_birthday
  json.end employee.emp_birthday
  json.type "birthday"
end


