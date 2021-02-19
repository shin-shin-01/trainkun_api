# frozen_string_literal: true

class AuthorizationService
  def initialize(headers = {})
    @request_url = ENV['AUTHORIZATION_URL'] + extract_access_token(headers)
    @client_id = String(ENV['LINE_CLIENT_ID'])
  end

  def extract_access_token(headers)
    return headers['LINE_Authorization'] if headers['LINE_Authorization'].present?
    return ""
  end

  def verify_token
    require "net/http"

    uri = URI.parse(@request_url)
    response = Net::HTTP.get_response(uri)

    # check: statsuCode
    return false if response.code != 200

    # check: clientId
    return false if response.body.client_id != @client_id

    true
  end
end
