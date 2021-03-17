# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FriendWishes', type: :request do
  before { skip_token_authorization }

  let(:user) { create(:user) }
  let(:first_category) { create(:category) }
  let(:second_category) { create(:category) }
  # ２人の友達の wish
  let!(:first_wish) { create(:wish, user: first_friend_user, category: first_category) }
  let!(:second_wish) { create(:wish, user: second_friend_user, category: first_category) }
  # 異なるカテゴリーの wish
  let!(:second_category_wish) { create(:wish, user: first_friend_user, category: second_category) }
  # 自分の wish
  let!(:user_wish) { create(:wish, user: user, category: first_category) }
  # 友達となるユーザ
  let(:first_friend_user) { create(:user) }
  let(:second_friend_user) { create(:user) }

  # wish の画像
  let!(:first_wish_image) { create(:image, wish: first_wish) }
  let!(:second_wish_image) { create(:image, wish: second_wish) }
  let!(:second_category_wish_image) { create(:image, wish: second_category_wish) }
  let!(:user_wish_image) { create(:image, wish: user_wish) }

  describe 'GET /users/:uid/friend_wishes' do
    let(:request) { get "/api/v1/users/#{user.uid}/friend_wishes" }

    before do
      create(:friend, user: user, friend_user: first_friend_user)
      create(:friend, user: user, friend_user: second_friend_user)
    end

    context 'SUCCESS: #index users friend_wishes' do
      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: OK'

      it 'returns: users friend_wishes' do
        request
        expect(json['data']).to match(
          {
            first_category.name => [
              {
                'id' => first_wish.id,
                'user_id' => first_friend_user.id,
                'user_name' => first_friend_user.name,
                'user_picture_url' => first_friend_user.picture_url,
                'category_id' => first_category.id,
                'category_name' => first_category.name,
                'name' => first_wish.name,
                'star' => first_wish.star,
                'status' => first_wish.status,
                'deleted' => first_wish.deleted,
                'image_url' => first_wish_image.url
              },
              {
                'id' => second_wish.id,
                'user_id' => second_friend_user.id,
                'user_name' => second_friend_user.name,
                'user_picture_url' => second_friend_user.picture_url,
                'category_id' => first_category.id,
                'category_name' => first_category.name,
                'name' => second_wish.name,
                'star' => second_wish.star,
                'status' => second_wish.status,
                'deleted' => second_wish.deleted,
                'image_url' => second_wish_image.url
              }
            ],
            second_category.name => [
              {
                'id' => second_category_wish.id,
                'user_id' => first_friend_user.id,
                'user_name' => first_friend_user.name,
                'user_picture_url' => first_friend_user.picture_url,
                'category_id' => second_category.id,
                'category_name' => second_category.name,
                'name' => second_category_wish.name,
                'star' => second_category_wish.star,
                'status' => second_category_wish.status,
                'deleted' => second_category_wish.deleted,
                'image_url' => second_category_wish_image.url
              }
            ]
          }
        )
      end
    end

    context 'Errors: user Not Found' do
      let(:fake_uid) { Faker::Alphanumeric.alpha(number: 10) }
      let(:request) { get "/api/v1/users/#{fake_uid}/friend_wishes" }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: NOT FOUND'
    end
  end
end
