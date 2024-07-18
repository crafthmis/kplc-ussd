FactoryBot.define do
  factory :complaint do
    customer { "" }
    info { "MyString" }
    complaintable { nil }
  end
end
