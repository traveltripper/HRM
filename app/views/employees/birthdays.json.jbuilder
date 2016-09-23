json.array! @emp do |event|

  json.id event.id
  json.title event.fullname
  json.start event.actual_dob.beginning_of_day
  json.end event.actual_dob.end_of_day
end


