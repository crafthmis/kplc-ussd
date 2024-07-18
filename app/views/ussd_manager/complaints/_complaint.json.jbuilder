json.extract! complaint, :id, :customer, :info, :complaintable_id, :complaintable_type, :created_at, :updated_at
json.url complaint_url(complaint, format: :json)
