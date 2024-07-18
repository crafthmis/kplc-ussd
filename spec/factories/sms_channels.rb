FactoryBot.define do
  factory :sms_channel do
    type { "" }
    shortcode { "MyString" }
    alphanumeric { "MyString" }
    keyword { "MyString" }
    organization { nil }
  end
end
