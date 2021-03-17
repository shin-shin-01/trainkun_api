# frozen_string_literal: true

module Api
  module V1
    module Users
      class ImagesController < ApplicationController
        before_action :set_user, only: %i[create]
        before_action :set_wish, only: %i[create]

        # POST /users/:uid/image
        def create
          new_image = Image.new(image_params.merge({ wish: @wish }))

          if new_image.save
            render json: { data: ImageSerializer.new(new_image) }, status: :created
          else
            render json: { error: 'Failed to create new Image', data: new_image.errors }, status: :bad_request
          end
        end

        private

        def set_user
          @user = User.find_by(uid: params[:uid])
          render json: { error: 'user not found' }, status: :not_found unless @user
        end

        def set_wish
          @wish = @user.wishes.find_by(id: wish_params[:id])
          render json: { error: 'wish not found' }, status: :not_found unless @wish
        end

        def wish_params
          params.require(:wish).permit(:id)
        end

        def image_params
          params.require(:image).permit(:url)
        end
      end
    end
  end
end
