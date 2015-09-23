require 'spec_helper'

describe BillService do

  subject(:bill_service) { described_class.new }

  describe '#fetch_bill' do
    it 'returns a bill' do
      bill = subject.fetch_bill
      expect(bill).to be_a_kind_of(Hash)
      expect(bill).to include('statement', 'total', 'package', 'callCharges', 'skyStore')
    end
  end

end
