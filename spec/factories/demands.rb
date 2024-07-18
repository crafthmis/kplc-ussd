FactoryBot.define do
  factory :demand do
    request_id { "MyString" }
    request_timestamp { "MyString" }
    channel { "MyString" }
    offer_code { "MyString" }
    customer { nil }
    link_id { "MyString" }
    content { "MyString" }
    error_code { 100 }
  end
end
