# frozen_string_literal: true

class AuthorizationService
  def initialize(headers = {})
    @request_url = ENV['AUTHORIZATION_URL'] + headers['LINE_Authorization']
    @client_id = String(ENV['LINE_CLIENT_ID'])
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
