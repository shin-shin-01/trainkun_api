# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      # POST /users
      # return Userinfo
      def create
        new_user = User.new(user_params)
        user = User.find_by(uid: user_params[:uid])

        if new_user.save
          render json: { user: UserSerializer.new(new_user) }, status: :created
        elsif user # 既に作成されている場合
          render json: { user: UserSerializer.new(user) }, status: :ok
        else # パラメータでエラーが発生した場合
          render json: { erorr: 'Faild to create new user', data: new_user.errors }, status: :bad_request
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :uid)
      end
    end
  end
end
