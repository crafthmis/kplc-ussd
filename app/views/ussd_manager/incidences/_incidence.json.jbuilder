json.extract! incidence, :id, :kind, :explanation, :customer_id, :created_at, :updated_at
json.url incidence_url(incidence, format: :json)
