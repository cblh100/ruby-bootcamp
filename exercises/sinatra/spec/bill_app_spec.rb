ENV['RACK_ENV'] = 'test'

require 'spec_helper'

describe BillApp do
  include Rack::Test::Methods

  def app
    described_class
  end

  it "says hello" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('hello')
  end
  
end
