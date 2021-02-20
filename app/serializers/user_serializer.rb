# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id
  attributes :name
  attributes :uid
end
