require 'net/http'
require 'json'
require 'faraday'

class OAuth

  attr_reader :client_id, :client_secret, :expires_at

  OAUTH_URI = 'https://datamarket.accesscontrol.windows.net/v2/OAuth2-13'
  SCOPE = 'http://api.microsofttranslator.com/'
  GRANT_TYPE = 'client_credentials'

  def initialize(client_id, client_secret)
    @client_id = client_id
    @client_secret = client_secret
    @access_token = nil
    @expires_at = Time.now
  end

  def token
    return @access_token if expires_at > Time.now #TODO: Should I include a margin of error (i.e. 10 secs?)
    get_new_token
  end

  def get_new_token

    conn = Faraday.new(:url => OAUTH_URI) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end

    response = conn.post do |req|
      req.body = { 'client_id' => client_id, 'client_secret' => client_secret, 'scope' => SCOPE, 'grant_type' => GRANT_TYPE }
    end

    parsed_response = JSON.parse(response.body)

    @access_token = parsed_response['access_token']
    @expires_at = Time.now + parsed_response['expires_in'].to_i

    @access_token
  end

end