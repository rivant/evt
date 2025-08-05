FactoryBot.define do
  factory :connection do
    association :user  # create(:user)
    first_name { "John" }
    last_name  { "Doe" }
    relation   { "Friend" }
    sequence(:email) { |n| "jd#{n}@example.com" }
  end
end
