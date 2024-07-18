FactoryBot.define do
  factory :sms_manager_sms_channel, class: 'SmsManager::SmsChannel' do
    type { "" }
    shortcode { "MyString" }
    alphanumeric { "MyString" }
    keyword { "MyString" }
    organization { nil }
  end
end
