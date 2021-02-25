# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Friends', type: :request do
  before { skip_token_authorization }

  let(:user) { create(:user) }

  describe 'GET /users/:uid/friends' do
    let(:request) { get "/api/v1/users/#{user.uid}/friends" }

    let(:first_friend_user) { create(:user)}
    let!(:first_friend) { create(:friend, user:user, friend_user: first_friend_user) }

    let(:second_friend_user) { create(:user)}
    let!(:second_friend) { create(:friend, user:user, friend_user: second_friend_user) }

    context 'SUCCESS: #index users friends' do

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: OK'

      it 'returns: users friends' do
        request
        expect(json['data']).to match([
          {
          'id' => first_friend.id,
          'name' => first_friend_user.name,
          'picture_url' => first_friend_user.picture_url,
      },{
        'id' => second_friend.id,
        'name' => second_friend_user.name,
        'picture_url' => second_friend_user.picture_url,
    }
      ])

      end
    end

    context 'Errors: user Not Found' do
      let(:fake_uid) { Faker::Alphanumeric.alpha(number: 10) }
      let(:request) { get "/api/v1/users/#{fake_uid}/friends" }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: NOT FOUND'
    end
  end

  describe 'POST /users/:uid/friends' do
    let(:request) { post "/api/v1/users/#{user.uid}/friends", headers: { ACCEPT: 'application/json' }, as: :json, params: { friend: friend_params } }

    let(:friend_params) do
      {
        friend_user_id: friend_user_id
      }
    end

    let(:friend_user) { create(:user) }
    let(:friend_user_id) { friend_user.id }

    context 'SUCCESS: create friend' do
      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: CREATED'
      it 'increase total number of friend 1' do
        expect { request }.to change { Friend.count }.by(1)
      end

      it 'returns: created friend' do
        request
        expect(json['data']).to include(
          {
            'user_id' => user.id,
            'friend_user_id' => friend_user.id,
            'deleted' => false
          }
        )
      end
    end

    context 'ERROR: friend already registerd' do
      before { create(:friend, user: user, friend_user: friend_user) }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: BAD REQUEST'
      it 'increase total number of friend 0' do
        expect { request }.to change { Friend.count }.by(0)
      end

      it 'returns: error already registerd' do
        request
        expect(json).to match(
          {
            "error" => "Failed to create new Friend",
            "data" => { "friend_user_id"=>["already registered"] }
          }
        )
      end
    end

    context 'Errors: user Not Found' do
      let(:fake_uid) { Faker::Alphanumeric.alpha(number: 10) }
      let(:request) { post "/api/v1/users/#{fake_uid}/friends", headers: { ACCEPT: 'application/json' }, as: :json, params: { friend: friend_params } }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: NOT FOUND'
    end

    context 'Errors: frend Not Found' do
      let(:request) { post "/api/v1/users/#{user.uid}/friends", headers: { ACCEPT: 'application/json' }, as: :json, params: { friend: friend_params } }
      let(:friend_user_id) { Faker::Alphanumeric.alpha(number: 10) }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: NOT FOUND'
    end
  end
end
