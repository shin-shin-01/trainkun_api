# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Wishes', type: :request do
  before { skip_token_authorization }

  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:other_category) { create(:category) }

  # 取得する 2つの wish
  let!(:first_wish) { create(:wish, user: user, category: category) }
  let!(:second_wish) { create(:wish, user: user, category: category) }
  # 異なるカテゴリーの wish
  let!(:other_category_wish) { create(:wish, user: user, category: other_category) }
  # 異なるユーザの wish
  let!(:other_user_wish) { create(:wish, user: create(:user), category: category) }

  describe 'GET /users/:uid/wishes' do
    let(:request) { get "/api/v1/users/#{user.uid}/wishes" }

    context 'SUCCESS: #index users wishes' do
      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: OK'

      it 'returns: users wishes' do
        request
        # created_at の確認があるため　最初の 2つだけ確認する
        expect(json['data'][category.name][0]).to include(
          'id' => first_wish.id,
          'user_id' => user.id,
          'category_id' => category.id,
          'name' => first_wish.name,
          'star' => first_wish.star,
          'status' => first_wish.status,
          'deleted' => first_wish.deleted
        )
        expect(json['data'][other_category.name][0]).to include(
          'id' => other_category_wish.id,
          'user_id' => user.id,
          'category_id' => other_category.id,
          'name' => other_category_wish.name,
          'star' => other_category_wish.star,
          'status' => other_category_wish.status,
          'deleted' => other_category_wish.deleted
        )
      end
    end

    context 'Errors: user Not Found' do
      let(:fake_uid) { Faker::Alphanumeric.alpha(number: 10) }
      let(:request) { get "/api/v1/users/#{fake_uid}/wishes?category_id=#{category.id}" }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: NOT FOUND'
    end
  end

  describe 'POST /users/:uid/wishes' do
    let(:request) { post "/api/v1/users/#{user.uid}/wishes", headers: { ACCEPT: 'application/json' }, as: :json, params: { wish: wish_params } }

    let(:wish_params) do
      {
        name: name,
        star: star,
        category_id: category_id
      }
    end

    let(:name) { Faker::Alphanumeric.alpha(number: 10) }
    let(:star) { Faker::Number.within(range: 1..5) }
    let(:category_id) { category.id }

    context 'SUCCESS: create wish' do
      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: CREATED'
      it 'increase total number of wish 1' do
        expect { request }.to change { Wish.count }.by(1)
      end

      it 'returns: created wish' do
        request
        expect(json['data']).to include(
          {
            'user_id' => user.id,
            'category_id' => category.id,
            'name' => name,
            'star' => star,
            'status' => 'wish',
            'deleted' => false
          }
        )
      end
    end

    context 'ERROR: not name in params' do
      let(:name) { nil }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: BAD REQUEST'
    end

    context 'ERROR: not star in params' do
      let(:star) { nil }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: BAD REQUEST'
    end

    context 'ERROR: category not found' do
      let(:category_id) { nil }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: NOT FOUND'
    end

    context 'Errors: user Not Found' do
      let(:fake_uid) { Faker::Alphanumeric.alpha(number: 10) }
      let(:request) { post "/api/v1/users/#{fake_uid}/wishes", headers: { ACCEPT: 'application/json' }, as: :json, params: { wish: wish_params } }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: NOT FOUND'
    end
  end
end
