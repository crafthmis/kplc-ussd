FactoryBot.define do
  factory :campaign do
    name { "MyString" }
    type { "" }
    audience { nil }
    message { "MyText" }
    user { nil }
  end
end
