require_relative 'lib/linguine'
require_relative 'lib/pages/about_page'
require_relative 'lib/pages/home_page'

class MySite
  include Linguine

  page '/', HomePage
  page '/about', AboutPage

end

run MySite.new
