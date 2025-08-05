# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }

    trait :with_connections do
      transient do
        connections_count { 1 }
      end

      after(:create) do |user, evaluator|
        create_list(:connection, evaluator.connections_count, user: user)
      end
    end
  end
end
