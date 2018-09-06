FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "iamdeburyne#{n}@gmail.com" }
    sequence(:password) { |n| "iamdeburyne#{n}" }
    first_name { "Kevin" }
    last_name { "De Bruyne" }
    position { "MF" }
    company { "Manchester City" }
    profile { "A great soccer player" }
  end
end
