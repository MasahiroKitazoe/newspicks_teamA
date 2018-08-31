FactoryBot.define do
  factory :user do
    email { "iamdeburyne@gmail.com" }
    password { "iamdeburyne" }
    first_name { "Kevin" }
    last_name { "De Bruyne" }
    position { "MF" }
    company { "Manchester City" }
    profile { "A great soccer player" }
  end
end
