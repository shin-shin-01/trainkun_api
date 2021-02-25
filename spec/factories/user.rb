# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Alphanumeric.alpha(number: 10) }
    uid { Faker::Alphanumeric.unique.alphanumeric(number: 20, min_alpha: 10) }
    account_id { Faker::Alphanumeric.unique.alpha(number: 5) }
    picture_url { Faker::Alphanumeric.alpha(number: 10) }
  end
end
