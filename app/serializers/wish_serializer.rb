# frozen_string_literal: true

class WishSerializer < ActiveModel::Serializer
  attribute :id
  attribute :user_id
  attribute :category_id
  attribute :name
  attribute :star
  attribute :status
  attribute :deleted
end
