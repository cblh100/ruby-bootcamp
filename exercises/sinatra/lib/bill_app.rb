require 'sinatra'

class BillApp < Sinatra::Base

  use Rack::Auth::Basic, 'Sky Bill' do |username, password|
    username == 'username' && password == 'password'
  end

  get '/' do
    'hello'
  end

end
