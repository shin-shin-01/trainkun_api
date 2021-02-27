# frozen_string_literal: true

class User < ApplicationRecord
  has_many :wishes, dependent: :restrict_with_error
  has_many :friends, class_name: 'Friend', inverse_of: :user, dependent: :restrict_with_error
  has_many :friend_users, class_name: 'Friend', inverse_of: :user, foreign_key: 'friend_user_id', dependent: :restrict_with_error

  validates :name, length: { maximum: 255 }, presence: true
  validates :uid, length: { maximum: 255 }, presence: true, uniqueness: { case_sensitive: true }
  validates :account_id, length: { maximum: 255 }, presence: true, uniqueness: { case_sensitive: true }
  validates :picture_url, length: { maximum: 255 }

  default_scope { order(id: :asc) }
end
