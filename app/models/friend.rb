# frozen_string_literal: true

class Friend < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :friend_user, class_name: 'User'

  validates :friend_user_id,
            uniqueness: {
              scope: :user_id,
              message: 'already registered'
            }

  validates :deleted, inclusion: { in: [true, false] }
end
