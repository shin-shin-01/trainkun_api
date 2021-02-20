# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  before { skip_token_authorization }

  describe 'POST /categories' do
    let(:headers) { { ACCEPT: 'application/json' } }
    let(:endpoint) { '/api/v1/categories' }
    let(:request) { post endpoint, headers: headers, as: :json, params: { category: category_params } }

    let(:category_params) { { name: name } }
    let(:name) { Faker::Alphanumeric.alpha(number: 10) }

    context 'SUCCESS' do
      before { request }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: CREATED'
    end

    context 'SUCCESS on save' do
      it 'increase total number of category by 1' do
        expect { request }.to change { Category.count }.by(1)
      end
    end

    context 'ERROR: name not found' do
      let(:name) { nil }

      before { request }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: BAD REQUEST'
    end
  end

  describe 'GET /categories' do
    let(:endpoint) { '/api/v1/categories' }

    let!(:first_category) { create(:category) }
    let!(:second_category) { create(:category) }

    context 'SUCCESS' do
      before { get endpoint }

      it_behaves_like 'API returns json'
      it_behaves_like 'response status code: OK'
      it 'returns two category' do
        expect(json['categories'].size).to eq 2

        expect(json['categories'][0]['id']).to eq first_category.id
        expect(json['categories'][0]['name']).to eq first_category.name

        expect(json['categories'][1]['id']).to eq second_category.id
        expect(json['categories'][1]['name']).to eq second_category.name
      end
    end
  end
end
