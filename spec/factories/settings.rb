FactoryBot.define do
  factory :setting do
    ussd_sms { false }
    prepaid_token { false }
    postpaid_token { false }
    find_contractor { false }
    find_employee { false }
    short_code { false }
  end
end
