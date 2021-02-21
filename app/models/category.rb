# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :wishes, dependent: :restrict_with_error

  validates :name, length: { maximum: 255 }, presence: true

  default_scope { order(id: :asc) }
end
