# frozen_string_literal: true

class Wish < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, length: { maximum: 255 }, presence: true
  validates :star,
            numericality: { only_integer: true, greater_than: 0, less_than: 6 },
            presence: true

  enum status: {
    wish: 0, # 欲しい
    bougth: 1 # 購入済み
  }
  validates :status, presence: true

  validates :deleted, inclusion: { in: [true, false] }

  default_scope { order(star: :desc).where(deleted: false) }
end
