# frozen_string_literal: true

module Api
  module V1
    module Users
      class FriendWishesController < ApplicationController
        before_action :set_user, only: %i[index]
        before_action :set_friends_id, only: %i[index]

        # GET /users/:uid/friend_wishes
        def index
          # { "categoryname": [ wish, wish, ], ... }
          friend_wishes = {}
          Category.all.each do |category|
            friend_wishes[category.name] = (ActiveModelSerializers::SerializableResource.new(
              Wish.where(user_id: @friend_user_ids, category_id: category.id),
              each_serializer: FriendWishSerializer,
              root: category.name
            ).serializable_hash)[:"#{category.name}"]
          end
          render json: { data: friend_wishes }, status: :ok
        end

        private

        def set_user
          @user = User.find_by(uid: params[:uid])
          render json: { error: 'user not found' }, status: :not_found unless @user
        end

        def set_friends_id
          # return 配列
          @friend_user_ids = @user.friends.pluck(:friend_user_id)
        end
      end
    end
  end
end
