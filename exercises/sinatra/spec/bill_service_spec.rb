require 'spec_helper'

describe BillService do

  subject(:bill_service) { described_class.new }

  let(:bill) do
    File.read('bill.json')
  end

  describe '#fetch_bill' do
    it 'returns a bill' do
      stub_request(:get, %r{.*/bill\.json$}).to_return(body: bill)
      bill = subject.fetch_bill
      expect(bill).to respond_to('statement', 'total', 'package', 'callCharges', 'skyStore')
      expect(WebMock).to have_requested(:get, %r{.*/bill\.json$})
    end
  end

end
