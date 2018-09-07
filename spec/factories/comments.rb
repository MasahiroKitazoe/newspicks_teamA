FactoryBot.define do
  factory :comment do
    sequence(:comment) {|n| "This is a comment vol.#{n}"}
    association :pick
    association :user
  end
end
