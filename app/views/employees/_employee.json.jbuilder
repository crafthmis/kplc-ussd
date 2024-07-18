json.extract! employee, :id, :first_name, :middle_name, :last_name, :staff_number, :job_category, :region, :station, :job_title, :division, :section, :created_at, :updated_at
json.url employee_url(employee, format: :json)
