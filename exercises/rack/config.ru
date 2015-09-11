require_relative 'lib/linguine'

class MySite
  include Linguine

  page '/' do
    'Welcome to the home page' # HTML could be rendered here
  end

  page '/about' do
    'some interesting information'
  end

end

run MySite.new
