FactoryBot.define do
  factory :billable do
    request_id { "MyString" }
    request_timestamp { "MyString" }
    response_id { "MyString" }
    channel { "MyString" }
    offer_code { "MyString" }
    customer { nil }
    content { "MyString" }
    meter { nil }
    account { nil }
    response { "MyString" }
  end
end
