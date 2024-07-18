json.extract! demand, :id, :request_id, :request_timestamp, :channel, :operation, :offer_code, :customer_id, :link_id, :content, :created_at, :updated_at
json.url demand_url(demand, format: :json)
