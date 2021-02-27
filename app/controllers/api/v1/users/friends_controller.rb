# frozen_string_literal: true

module Api
  module V1
    module Users
      class FriendsController < ApplicationController
        before_action :set_user, only: %i[index create]
        before_action :set_friend_user, only: %i[create]

        # GET /users/:uid/friends
        def index
          render json: @user.friends, each_serializer: FriendSerializer, root: 'data'
        end

        # POST /users/:uid/friends
        def create
          new_friend = Friend.new({ user: @user, friend_user: @friend_user, deleted: false })

          if new_friend.save
            render json: { data: new_friend }, status: :created
          else
            render json: { error: 'Failed to create new Friend', data: new_friend.errors }, status: :bad_request
          end
        end

        private

        def set_user
          @user = User.find_by(uid: params[:uid])
          render json: { error: 'user not found' }, status: :not_found unless @user
        end

        def set_friend_user
          @friend_user = User.find_by(id: friend_params[:friend_user_id])
          render json: { error: 'user not found' }, status: :not_found unless @friend_user
        end

        def friend_params
          params.require(:friend).permit(:friend_user_id)
        end
      end
    end
  end
end
