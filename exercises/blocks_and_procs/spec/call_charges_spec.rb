require 'spec_helper'

describe CallCharges do

  describe '#new' do

    it 'raises an ArgumentError when no block is passed' do
      expect{ CallCharges.new }.to raise_error(ArgumentError, 'You must pass a block to initialize the CallCharges')
    end

    it 'requires a block to be passed' do
      expect(CallCharges.new {}).to be_instance_of(CallCharges)
    end

    it 'sets the attributes' do
      call_charges = CallCharges.new do
        call '07716393769' do
          date Date.parse('2015-02-01')
          duration "00:23:03"
          cost 1.13
        end
      end
      expect(call_charges.calls).not_to be_empty
    end

  end
end