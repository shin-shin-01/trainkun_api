# frozen_string_literal: true

class FriendWishSerializer < ActiveModel::Serializer
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
  attribute :user_picture_url do
    object.user.picture_url
  end

  attribute :category_name do
    object.category.name
  end

  # 画像がない場合は デフォルト画像
  # TODO: 複数画像に対応
  attribute :image_url do
    latest_image = object.images.last
    latest_image.nil? ? 'https://firebasestorage.googleapis.com/v0/b/wish-image-ae34c.appspot.com/o/default%2FdefaultNoImage.png?alt=media&token=391f1ff8-14a5-4cce-91ac-16ea751b3462' : latest_image.url
  end
end
