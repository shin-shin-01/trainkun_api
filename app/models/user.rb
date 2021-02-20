# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, length: { maximum: 255 }, presence: true
  validates :uid, length: { maximum: 255 }, presence: true, uniqueness: { case_sensitive: true }

  default_scope { order(id: :asc) }
end
