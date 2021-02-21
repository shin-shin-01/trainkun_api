# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController
      # POST /categories
      def create
        new_category = Category.new(category_params)

        if new_category.save
          render json: { data: CategorySerializer.new(new_category) }, status: :created
        else
          render json: { error: 'Failed to create new Category', data: new_category.errors }, status: :bad_request
        end
      end

      # GET /categories
      def index
        render json: Category.all, each_serializer: CategorySerializer, root: 'data'
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
