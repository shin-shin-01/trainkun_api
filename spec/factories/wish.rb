# frozen_string_literal: true

FactoryBot.define do
  factory :wish do
    user { association(:user) }
    category { association(:category) }
    name { Faker::Alphanumeric.alpha(number: 10) }
    star { Faker::Number.within(range: 1..5) }
    status { 'wish' }
    deleted { false }
  end
end
