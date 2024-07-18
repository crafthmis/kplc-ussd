FactoryBot.define do
  factory :message do
    content { "MyString" }
    code { "MyString" }
    customer { nil }
    messageable { nil }
    service { 1 }
  end
end
