require 'spec_helper'

shared_examples 'a mover' do

  let(:name) { 'Mr Mover' }
  let(:mover) { described_class.new(name) }

  it 'is a mover' do
    expect(mover).to be_kind_of(RubyBootcamp::Modules::Mover)
  end

  describe '#move_left' do
    it 'moves the object one to the left' do
      expect(mover.move_left.position).to eq({:logitude => 0, :lattitude => 1 })
    end
  end

  describe '#move_right' do
    it 'moves the object one to the right' do
      expect(mover.move_right.position).to eq({:logitude => 0, :lattitude => -1 })
    end
  end

  describe '#move_forwards' do
    it 'moves the object one to the right' do
      expect(mover.move_forwards.position).to eq({:logitude => 1, :lattitude => 0 })
    end
  end

  describe '#move_backwards' do
    it 'moves the object one to the right' do
      expect(mover.move_backwards.position).to eq({:logitude => -1, :lattitude => 0 })
    end
  end

end

describe RubyBootcamp::Modules::Person do

  it_behaves_like 'a mover'

end

describe RubyBootcamp::Modules::Robot do

  it_behaves_like 'a mover'

end
