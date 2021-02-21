# frozen_string_literal: true

module Api
  module V1
    module Users
      class WishesController < ApplicationController
        before_action :set_user, only: %i[index create]
        before_action :set_category, only: %i[create]

        # GET /users/:uid/wishes?category_id=
        def index
          user_wishes_by_category = @user.wishes.where(category_id: params[:category_id])
          render json: user_wishes_by_category, each_serializer: WishSerializer, root: 'data'
        end

        # POST /users/:uid/wishes
        def create
          new_wish = Wish.new(wish_params.merge({ user: @user, category: @category, status: :wish, deleted: false }))

          if new_wish.save
            render json: { data: WishSerializer.new(new_wish) }, status: :created
          else
            render json: { error: 'Failed to create new Wish', data: new_wish.errors }, status: :bad_request
          end
        end

        private

        def set_user
          @user = User.find_by(uid: params[:uid])
          render json: { error: 'user not found' }, status: :not_found unless @user
        end

        def set_category
          @category = Category.find_by(id: category_params[:category_id])
          render json: { error: 'category not found' }, status: :not_found unless @category
        end

        def wish_params
          params.require(:wish).permit(:name, :star)
        end

        def category_params
          params.require(:wish).permit(:category_id)
        end
      end
    end
  end
end
