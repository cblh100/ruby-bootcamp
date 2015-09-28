require 'sinatra'

class BillServiceApp < Sinatra::Base

  get '/bill.json' do
    content_type 'application/json'
    File.read('bill.json')
  end

end