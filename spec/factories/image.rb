# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    wish { association(:wish) }
    url { Faker::Alphanumeric.alpha(number: 10) }
  end
end
