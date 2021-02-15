# frozen_string_literal: true

class QrScan < ApplicationRecord
  validates :name, length: { maximum: 255 }, presence: true
end
