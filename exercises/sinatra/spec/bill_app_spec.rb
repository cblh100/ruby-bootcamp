ENV['RACK_ENV'] = 'test'

require 'spec_helper'
require 'pry'

describe BillApp do
  include Rack::Test::Methods

  def app
    described_class
  end

  let(:bill_uri) { '/' }

  it 'needs authentication' do
    get bill_uri
    expect(last_response).to be_unauthorized
    expect(last_response.header).to include('WWW-Authenticate' => 'Basic realm="Sky Bill"')
  end

  it 'fails with invalid credentials' do
    authorize 'mrhacker', 'l33t'
    get bill_uri
    expect(last_response).to be_unauthorized
  end

  it 'valid credentials' do
    authorize 'username', 'password'
    get bill_uri
    expect(last_response).to be_ok
    expect(last_response.body).to include('Sky Bill')
  end

end
