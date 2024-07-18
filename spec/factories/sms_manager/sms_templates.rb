FactoryBot.define do
  factory :sms_manager_sms_template, class: 'SmsManager::SmsTemplate' do
    name { "MyString" }
    message { "MyText" }
  end
end
