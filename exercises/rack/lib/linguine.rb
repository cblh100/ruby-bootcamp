require 'rack'
require 'pry'
require 'nokogiri'
require_relative 'oauth'
require_relative 'ms_translator'

module Linguine

  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods

    def mappings
      @mappings ||= {}
    end

    def page(uri, page)
      mappings[uri] = page
    end

  end

  def oauth
    @oauth ||= OAuth.new('ddWDU0TuNZyoiAWtuhQn','Aez85ARdCZVpcKEKgOXOqBpai3SELO43MxdtI1Ml4KQ=')
  end

  def translator
    @translator ||= MsTranslator.new(oauth)
  end

  def cache
    @cache ||= {}
  end

  def add_to_cache(text, language, translated_text)
    if cache[text]
      cache[text][language] = translated_text
    else
      cache[text] = { language => translated_text }
    end
  end

  def call(env)
    request_path, language = split_path(env['REQUEST_PATH'])
    mappings = self.class::mappings
    return [404, {'Content-Type' => 'text/plain'}, 'Oooops, there is nothing here' ] unless mappings[request_path]

    page = mappings[request_path].new(env)

    response_body = case page.content_type
                      when 'text/html' then translate_html(page.body, language)
                      when 'text/plain' then translate(page.body, language)
                      else page.body #Don't translate
                    end

    [200, {'Content-Type' => page.content_type}, response_body]
  end

  TRANSLATABLE_TAGS = %w(title p a h1 h2 h3 h4 h5 h6)

  def translate_html(html_text, language)
    html = Nokogiri::HTML(html_text)
    TRANSLATABLE_TAGS.each do |tag|
      html.css(tag).each do |node|
        text_nodes = node.children.select { |it| it.text? }
        text_nodes.each { |text| text.content = translate( text.content, language ) }
      end
    end
    html.to_s
  end


  def translate(text, language)
    return cache[text][language] if cache[text] && cache[text][language]

    translated_text = translator.translate(text, 'en', language || 'en')
    add_to_cache( text, language, translated_text)
    translated_text
  end

  def split_path(request_path)
    /^(?<path>.*?)(\.(?<language>[a-z\-]+)){0,1}$/.match(request_path) do |m|
      [m['path'], m['language']]
    end
  end

end

#Fudge to get round the loss of the each method on the String class
class String
  alias_method :each, :each_line
end

