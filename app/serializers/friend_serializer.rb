# frozen_string_literal: true

class FriendSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name do
    object.friend_user.name
  end

  attribute :picture_url do
    object.friend_user.picture_url
  end
end
