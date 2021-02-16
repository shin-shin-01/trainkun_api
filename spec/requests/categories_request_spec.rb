# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
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
end
