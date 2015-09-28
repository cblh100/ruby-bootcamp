require 'sinatra'

class BillServiceApp < Sinatra::Base

  get '/bill.json' do
    File.read('bill.json')
  end

end