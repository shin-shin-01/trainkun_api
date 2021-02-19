# frozen_string_literal: true

class AuthorizationService
  def initialize(headers = {})
    @request_url = ENV['AUTHORIZATION_URL'] + extract_access_token(headers)
    @client_id = String(ENV['LINE_CLIENT_ID'])
  end

  def extract_access_token(headers)
    return headers['LINEAuthorization'] if headers['LINEAuthorization'].present?
    return ""
  end

  def verify_token
    require "net/http"

    uri = URI.parse(@request_url)
    response = Net::HTTP.get(uri)

    # check: clientId
    return false if response['client_id'] != @client_id
    true
  end
end
