# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, length: { maximum: 255 }, presence: true

  default_scope { order(id: :asc) }
end
