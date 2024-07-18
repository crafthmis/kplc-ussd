FactoryBot.define do
  factory :request do
    text { "" }
    sequence(:session_id) { |n| "ATUid_26814e5e9dd5dda7b0046affa1e0a87#{n}"}
    kind { 1 }
    customer 
  end
end
