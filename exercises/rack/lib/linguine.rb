require 'rack'
require 'pry'

module Linguine

  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    attr_accessor :mappings

    def page(uri, &block)
      @mappings ||= {}
      @mappings[uri] = block
    end

  end

  def call(env)
    request_path = env['REQUEST_PATH']
    mappings = self.class::mappings
    return [404, {"Content-Type" => "text/plain"}, "Oooops, there is nothing here" ] unless mappings && mappings[request_path]
    [200, {"Content-Type" => "text/plain"}, mappings[request_path].call]
  end

end

#Fudge to get round the loss of the each methos the String class
class String
  alias_method :each, :each_line
end
