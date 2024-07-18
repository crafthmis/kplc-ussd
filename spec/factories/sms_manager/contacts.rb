FactoryBot.define do
  factory :sms_manager_contact, class: 'SmsManager::Contact' do
    name { "MyString" }
    number { "MyString" }
  end
end
