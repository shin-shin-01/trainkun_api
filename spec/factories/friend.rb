# frozen_string_literal: true

FactoryBot.define do
  factory :friend do
    user { association(:user) }
    friend_user { association(:user) }
    deleted { false }
  end
end
