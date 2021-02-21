# frozen_string_literal: true

class User < ApplicationRecord
  has_many :wishes, dependent: :restrict_with_error

  validates :name, length: { maximum: 255 }, presence: true
  validates :uid, length: { maximum: 255 }, presence: true, uniqueness: { case_sensitive: true }

  default_scope { order(id: :asc) }
end
