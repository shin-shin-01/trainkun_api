# frozen_string_literal: true

class WishSerializer < ActiveModel::Serializer
  attribute :id
  attribute :user_id
  attribute :category_id
  attribute :name
  attribute :star
  attribute :status
  attribute :deleted

  attribute :user_name do
    object.user.name
  end
  attribute :category_name do
    object.category.name
  end
  # 画像がない場合は デフォルト画像
  # TODO: 複数画像に対応
  attribute :image_url do
    latest_image = object.images.last
    latest_image.nil? ? ENV['DEFAULT_IMAGE_URL'] : latest_image.url
  end
end
