# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :uid
  attribute :account_id
end
