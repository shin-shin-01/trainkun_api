# frozen_string_literal: true

RSpec.shared_examples 'API returns json' do
  specify do
    request
    expect(response.content_type).to eq('application/json; charset=utf-8')
  end
end

RSpec.shared_examples 'response status code: OK' do
  specify do
    request
    expect(response).to have_http_status(:ok)
  end
end

RSpec.shared_examples 'response status code: CREATED' do
  specify do
    request
    expect(response).to have_http_status(:created)
  end
end

RSpec.shared_examples 'response status code: BAD REQUEST' do
  specify do
    request
    expect(response).to have_http_status(:bad_request)
  end
end

RSpec.shared_examples 'response status code: NOT FOUND' do
  specify do
    request
    expect(response).to have_http_status(:not_found)
  end
end

RSpec.shared_examples 'response status code: INTERNAL SERVER ERROR' do
  specify do
    request
    expect(response).to have_http_status(:internal_server_error)
  end
end
