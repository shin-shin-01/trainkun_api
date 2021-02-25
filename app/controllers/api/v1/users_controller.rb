# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController 
      serialization_scope :action_name

      # POST /users
      # return Userinfo
      def create
        new_user = User.new(user_params.merge({ account_id: SecureRandom.alphanumeric(5) }))
        user = User.find_by(uid: user_params[:uid])

        if new_user.save
          render json: new_user, serializer: UserSerializer, status: :created
        elsif user # 既に作成されている場合
          render json: user, serializer: UserSerializer, status: :ok
        else # パラメータでエラーが発生した場合
          render json: { erorr: 'Faild to create new user', data: new_user.errors }, status: :bad_request
        end
      end

      # GET /users/:id
      def show
        user = User.find_by(id: params[:id])
        if user
          render json: user, serializer: UserSerializer, root: 'data', status: :ok
        else
          render json: { error: 'user not found' }, status: :not_found
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :uid, :picture_url)
      end
    end
  end
end
