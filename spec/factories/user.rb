# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Alphanumeric.alpha(number: 10) }
    uid { Faker::Alphanumeric.unique.alphanumeric(number: 20, min_alpha: 10) }
  end
end
