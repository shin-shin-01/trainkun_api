# frozen_string_literal: true

class Image < ApplicationRecord
  belongs_to :wish
  validates :url, length: { maximum: 255 }, presence: true
end
