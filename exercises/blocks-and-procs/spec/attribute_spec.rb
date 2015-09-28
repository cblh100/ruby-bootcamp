require 'spec_helper'

describe Attribute do

  let(:test_class) { Class.new { extend Attribute } }
  let(:test_object) { test_class.new }

  describe '#attribute' do
    it 'adds a named attribute to a class' do
      test_class.attribute :foo
      expect(test_object).to respond_to(:foo)
    end

    it 'adds multiple named attributes to a class' do
      test_class.attribute :foo, :bar
      expect(test_object).to respond_to(:foo)
      expect(test_object).to respond_to(:bar)
    end

    let(:test_value) { 'test' }

    it 'the attributes allow getting and setting' do
      test_class.attribute :foo
      test_object.foo(test_value)
      expect(test_object).to have_attributes(foo: test_value)
      expect(test_object.foo).to eq(test_value)
    end

  end

end