require 'sinatra'
require 'slim'
require 'bill_service'
require 'bill_helper'

class BillApp < Sinatra::Base

  set :sessions, true

  helpers BillHelper

  def authenticate!
    redirect '/login' unless session[:username]
  end

  get '/' do
    authenticate!
    bill = bill_service.fetch_bill
    slim :index, locals: { title: 'Sky Bill', bill: bill }
  end

  get '/login' do
    slim :login, locals: { title: 'Login' }
  end

  post '/login' do
    if params[:username] == 'username' && params[:password] == 'password'
      session[:username] = params[:username]
      redirect '/'
    else
      session.delete :username
      slim :login_failed, locals: { title: 'Naughty naughty' }
    end
  end

  def bill_service
    @bill_service ||= BillService.new
  end

end
