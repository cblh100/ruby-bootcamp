require 'spec_helper'

describe Linguine do

  let(:dummy_class) { Class.new { include Linguine } }
  let(:dummy_object) { dummy_class.new }

  describe '::page' do

    it 'empty mappings hash' do
      expect(dummy_class.mappings).to be_nil
    end

    it 'store and call block' do
      dummy_class.page '/' do
        'Dummy Output'
      end
      expect(dummy_class.mappings).to include('/')
      expect(dummy_class.mappings['/'].call).to eq('Dummy Output')
    end

  end

  describe '#split_path' do

    it 'hash with only the path' do
      expect(dummy_object.split_path('/about')).to eq( { :path => '/about', :language => nil } )
    end

    it 'hash with path and the language' do
      expect(dummy_object.split_path('/about.de')).to eq( { :path => '/about', :language => 'de' } )
    end

    it 'hash with path and the extended language' do
      expect(dummy_object.split_path('/about.en-gb')).to eq( { :path => '/about', :language => 'en-gb' } )
    end

  end

end

