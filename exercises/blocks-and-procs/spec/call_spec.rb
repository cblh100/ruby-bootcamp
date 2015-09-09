require 'spec_helper'

describe Call do

  describe '#new' do

    it 'raises an ArgumentError when no block is passed' do
      expect{ Call.new '0123456789' }.to raise_error(ArgumentError, 'You must pass a block to initialize the Call')
    end

    it 'requires a block to be passed' do
      expect(Call.new('0123456789') {}).to be_instance_of(Call)
    end

    it 'sets the attributes' do
      call = Call.new '07716393769' do
        date Date.parse('2015-02-01')
        duration "00:23:03"
        cost 1.13
      end
      expect(call.called).to eq('07716393769')
      expect(call.date).to eq(Date.parse('2015-02-01'))
      expect(call.duration).to eq("00:23:03")
      expect(call.cost).to eq(1.13)
    end
  end
end