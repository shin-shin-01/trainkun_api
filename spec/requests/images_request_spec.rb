# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Images', type: :request do
  before { skip_token_authorization }

  let(:user) { create(:user) }
  let(:wish) { create(:wish, user: user) }

  describe 'POST /users/:uid/images' do
    let(:request) { post "/api/v1/users/#{user.uid}/images", headers: { ACCEPT: 'application/json' }, as: :json, params: { wish: wish_params, image: image_params } }

    let(:wish_params) { { id: wish.id } }
    let(:image_params) { { url: url } }

    let(:url) { Faker::Alphanumeric.alpha(number: 10) }

    context 'SUCCESS: create image' do
      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: CREATED'
      it 'increase total number of image 1' do
        expect { request }.to change { Image.count }.by(1)
      end

      it 'returns: created image' do
        request
        expect(json['data']).to include(
          {
            'wish_id' => wish.id,
            'url' => url
          }
        )
      end
    end

    context 'ERROR: not url in params' do
      let(:url) { nil }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: BAD REQUEST'
    end

    context 'ERROR: wish not found' do
      let(:wish_params) { { id: wish.id + 100 } }

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
