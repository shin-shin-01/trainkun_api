# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :picture_url

  attribute :uid, if: :create_users?
  attribute :account_id, if: :create_users?

  def create_users?
    action_name == 'create'
  end
end
