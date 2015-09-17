require_relative 'lib/linguine'
require_relative 'lib/pages/about_page'
require_relative 'lib/pages/home_page'
require_relative 'lib/google_translator'

#Monkey patch the linguine module to use google translate
module Linguine
#  def translator
#    @translator ||= GoogleTranslator.new
#  end
end


class MySite
  include Linguine

  page '/', HomePage
  page '/about', AboutPage

end

run MySite.new
