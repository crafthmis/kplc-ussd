FactoryBot.define do
  factory :sms_manager_campaign, class: 'SmsManager::Campaign' do
    name { "MyString" }
    type { "" }
    audience { nil }
    message { "MyText" }
  end
end
