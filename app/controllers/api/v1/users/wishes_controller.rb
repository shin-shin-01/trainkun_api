# frozen_string_literal: true

module Api
  module V1
    module Users
      class WishesController < ApplicationController
        before_action :set_user, only: %i[index create]
        before_action :set_category, only: %i[create]
        before_action :set_wish, only: %i[update]

        # GET /users/:uid/wishes
        def index
          # { "categoryname": [ wish, wish, ], ... }
          user_wishes = {}
          Category.all.each do |category|
            user_wishes[category.name] = (ActiveModelSerializers::SerializableResource.new(
              @user.wishes.where(category_id: category.id),
              each_serializer: WishSerializer,
              root: category.name
            ).serializable_hash)[:"#{category.name}"]
          end
          render json: { data: user_wishes }, status: :ok
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

        # PUT /users/:uid/wishes/:id
        def update
          if @wish.update(update_params)
            render json: { data: WishSerializer.new(@wish) }, status: :ok
          else
            render json: { error: "failed to update wish's property", data: @wish.errors }, status: :bad_request
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

        def set_wish
          @wish = Wish.find_by(id: params[:id])
          render json: { error: 'wish not found' }, status: :not_found unless @wish
        end

        def wish_params
          params.require(:wish).permit(:name, :star)
        end

        def category_params
          params.require(:wish).permit(:category_id)
        end

        def update_params
          params.require(:wish).permit(:name, :star, :deleted, :status, :category_id)
        end
      end
    end
  end
end
