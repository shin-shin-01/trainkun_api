# frozen_string_literal: true

class FriendSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name do
    object.user.name
  end

  attribute :picture_url do
    object.user.picture_url
  end
end
