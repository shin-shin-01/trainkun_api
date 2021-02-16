# frozen_string_literal: true

class CategorySerializer < ActiveModel::Serializer
  attributes :id
  attributes :name
  attributes :created_at
  attributes :updated_at
end
