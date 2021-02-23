# frozen_string_literal: true

FactoryBot.define do
  factory :wish do
    user { association(:user) }
    category { association(:category) }
    name { Faker::Alphanumeric.alpha(number: 10) }
    star { 1 }
    status { 'wish' }
    deleted { false }
  end
end
