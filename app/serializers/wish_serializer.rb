# frozen_string_literal: true

class WishSerializer < ActiveModel::Serializer
  attribute :id
  attribute :user_id
  attribute :category_id
  attribute :name
  attribute :star
  attribute :status
  attribute :deleted

  attribute :user_name do
    object.user.name
  end
  attribute :category_name do
    object.category.name
  end
end
