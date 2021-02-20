# frozen_string_literal: true

# Verify IdToken from Firebase before any actions within any controllers
class ApplicationController < ActionController::API
  before_action :authorize_request
  skip_before_action :authorize_request, only: [:hello]

  def hello
    render json: { status: 'SUCCESS', data: 'Hello WishApiServer' }, status: :ok
  end

  private

  def authorize_request
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized unless AuthorizationService.new(request.headers).verify_token
  end
end
