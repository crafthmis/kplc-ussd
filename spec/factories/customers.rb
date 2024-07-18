FactoryBot.define do
  factory :customer do
    name { "MyString" }
    sequence(:number) { |n| "2547127#{rand(1000..9999)}9"}
    email_notification { false }
    sms_notification { false }
    sequence(:email) { |n| "email#{n}@yahoo.com"}
  end
end
