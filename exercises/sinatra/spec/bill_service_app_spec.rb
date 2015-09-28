ENV['RACK_ENV'] = 'test'

require 'spec_helper'

describe BillServiceApp do
  include Rack::Test::Methods

  def app
    described_class
  end

  let(:bill_uri) { '/bill.json' }

  let(:expected_json) do
    file = File.read('bill.json')
    JSON.parse(file)
  end

  it 'returns a valid json bill' do
    get bill_uri
    expect(last_response).to be_ok
    expect(last_response.header['Content-Type']).to include('application/json')
    expect(JSON.parse(last_response.body)).to eq(expected_json)
  end

end