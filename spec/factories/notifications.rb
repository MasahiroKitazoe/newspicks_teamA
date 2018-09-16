FactoryBot.define do
  factory :notification do
    user nil
    notified_by nil
    comment nil
    notified_type "MyString"
    read false
  end
end
