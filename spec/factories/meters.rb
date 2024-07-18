FactoryBot.define do
 factory :meter do
    sequence(:number) { |n| "1234567#{rand(1000..9999)}9"}
    status { false }
  end

  factory :valid_meter , parent: :meter do
    number { "14243784684" }
  end

  factory :invalid_meter , parent: :meter do
    number { "12345678901" }
  end
end
