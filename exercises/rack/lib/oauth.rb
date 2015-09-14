require 'net/http'
require 'json'

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
    return @access_token if expires_at > Time.now
    get_new_token
  end

  def get_new_token
    url = URI(OAUTH_URI)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    #http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request.body = URI.encode_www_form( { 'client_id' => client_id, 'client_secret' => client_secret, 'scope' => SCOPE, 'grant_type' => GRANT_TYPE } )
    response = http.request(request)

    parsed_response = JSON.parse(response.read_body)

    @access_token = parsed_response['access_token']
    @expires_at = Time.now + parsed_response['expires_in'].to_i

    @access_token
  end

end