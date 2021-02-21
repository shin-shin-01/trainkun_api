# frozen_string_literal: true

class CategorySerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :created_at
  attribute :updated_at
end
