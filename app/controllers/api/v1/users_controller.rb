# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      # POST /users
      # return Userinfo
      def create
        new_user = User.new(user_params)

        if new_user.save
          render json: { user: UserSerializer.new(new_user) }, status: :created
        else
          render json: { user: UserSerializer.new(set_user) }, status: :created
        end
      end

      private

      def set_user
        return User.find_by(uid: user_params[:uid])
      end

      def user_params
        params.require(:user).permit(:name, :uid)
      end
    end
  end
end
