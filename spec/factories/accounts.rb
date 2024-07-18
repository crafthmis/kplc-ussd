FactoryBot.define do
 factory :account do
    sequence(:number) { |n| "1237#{rand(1000..9999)}9"}
    status { false }
  end

  factory :valid_account , parent: :account do
    number { "47042221" }
  end

  factory :invalid_account , parent: :account do
    number { "12345678901" }
  end
end
