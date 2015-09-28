require 'spec_helper'

describe BillHelper do

  let(:helper_class) { Class.new { include BillHelper } }
  let(:helper_object) { helper_class.new }

  describe '#format_currency' do
    it 'formats a float to a currency string' do
      expect(helper_object.format_currency(0)).to eq('£0.00')
      expect(helper_object.format_currency(0.00)).to eq('£0.00')
      expect(helper_object.format_currency(1.1)).to eq('£1.10')
      expect(helper_object.format_currency(123.14)).to eq('£123.14')
    end
  end

  describe '#format_date' do
    it 'formats a date string to friendly format' do
      expect(helper_object.format_date('2012-01-20')).to eq('20 Jan 2012')
      expect(helper_object.format_date('2012-01-03')).to eq('3 Jan 2012')
    end
  end


end