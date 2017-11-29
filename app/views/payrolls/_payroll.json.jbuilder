json.extract! payroll, :id, :employee_id, :attachment, :pay_date, :created_at, :updated_at
json.url payroll_url(payroll, format: :json)