# frozen_string_literal: true

class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :user

  validates :deleted, inclusion: { in: [true, false] }
end
