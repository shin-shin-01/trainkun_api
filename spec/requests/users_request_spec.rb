# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before { skip_token_authorization }

  describe 'POST /users' do
    let(:request) { post '/api/v1/users', headers: { ACCEPT: 'application/json' }, as: :json, params: { user: user_params } }

    let(:user_params) do
      {
        name: name,
        uid: uid,
        picture_url: picture_url
      }
    end

    let(:name) { Faker::Alphanumeric.alpha(number: 10) }
    let(:uid) { Faker::Alphanumeric.alpha(number: 10) }
    let(:picture_url) { Faker::Alphanumeric.alpha(number: 10) }

    context 'SUCCESS: createUser' do
      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: CREATED'
      it 'increase total number of user 1' do
        expect { request }.to change { User.count }.by(1)
      end

      it 'returns: created user' do
        request
        expect(json['user']).to include(
          {
            'name' => name,
            'uid' => uid,
            'picture_url' => picture_url
          }
        )
        # 作成された アカウントID は ５文字
        expect(json['user']['account_id'].size).to eq 5
      end
    end

    context 'SUCCESS: already created user' do
      let!(:user) { create(:user, name: name, uid: uid, picture_url: picture_url) }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: OK'
      it 'NOT: increase total number of user' do
        expect { request }.to change { User.count }.by(0)
      end

      it 'returns: created user' do
        request
        expect(json['user']).to include(
          {
            'name' => user.name,
            'uid' => user.uid,
            'picture_url' => picture_url
          }
        )
        # 作成された アカウントID は ５文字
        expect(json['user']['account_id'].size).to eq 5
      end
    end

    context 'ERROR: not name in params' do
      let(:name) { nil }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: BAD REQUEST'
    end

    context 'ERROR: not uid in params' do
      let(:uid) { nil }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: BAD REQUEST'
    end
  end

  describe 'GET /users/:id' do

    context 'SUCCESS' do
      let(:user) {create(:user)}
      let(:request) { get "/api/v1/users/#{user.id}" }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: OK'
      it 'returns: user' do
        request
        expect(json['data']).to match(
          {
            "id" => user.id,
            "name" => user.name,
            "picture_url" => user.picture_url
        })
      end
    end

    context 'ERROR: user not found' do
      let(:user_id) {Faker::Alphanumeric.alpha(number: 10) }
      let(:request) { get "/api/v1/users/#{user_id}" }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: NOT FOUND'
    end

  end
end
