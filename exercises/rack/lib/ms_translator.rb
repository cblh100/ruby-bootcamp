require 'net/http'
require 'pry'
require 'nokogiri'
require 'faraday'

class MsTranslator

  TRANSLATOR_URI = 'http://api.microsofttranslator.com/v2/Http.svc/Translate'

  def initialize(oauth)
    @oauth = oauth
  end

  def token
    @oauth.token
  end

  def translate(text, language_from, language_to)
    return text if language_from == language_to

    conn = Faraday.new(:url => TRANSLATOR_URI) do |faraday|
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get do |req|
      req.headers['Authorization'] = "Bearer #{token}"
      req.params['text'] = text
      req.params['from'] = language_from
      req.params['to'] = language_to
    end

    response_xml = Nokogiri::XML(response.body)
    response_xml.xpath('//xmlns:string').text
  end

end