FactoryBot.define do
  factory :mpesa do
    sequence(:merchant_request_id) { |n| "30176-14023343-#{n}"}
    sequence(:checkout_request_id) { |n| "ws_CO_24022020212504633#{n}"}


    customer_message { "MyString" }
    result_code { "0" }
    result_desc { "Success Request accepted for processing" }
    amount { "" }
    mpesa_receipt_number { "MyString" }
    transaction_date { "MyString" }
    customer { nil }
    mpesable { nil }
  end
end
