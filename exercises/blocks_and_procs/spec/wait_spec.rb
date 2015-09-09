require 'spec_helper'
require 'timecop'

describe Wait do

  describe '#until' do

    it 'raises an ArgumentError when no block is passed' do
      expect{ Wait.until }.to raise_error(ArgumentError, 'You must provide a block to execute')
    end

    it 'calls the block only once' do
      expect { Wait.until { puts 'Called'; true } }.to output( "Called\n" ).to_stdout
    end

    it 'calls the block three times' do
      count = 0
      expect { Wait.until { puts 'Called'; count += 1; count == 3 } }.to output( "Called\nCalled\nCalled\n" ).to_stdout
    end

    it 'fails with BlockTimeoutError when it does not succeed within default expiry time' do
      Timecop.scale(100) do
        start_time = Time.now
        expect{ Wait.until { false } }.to raise_error(Wait::BlockTimeoutError, 'Block failed to succeed within expiry time')
        expect( Time.now - start_time ).to be_within(0.1).of(5)
      end
    end

    it 'fails with BlockTimeoutError when it does not succeed within 10 seconds' do
      Timecop.scale(100) do
        start_time = Time.now
        expect{ Wait.until(0, 10) { false } }.to raise_error(Wait::BlockTimeoutError, 'Block failed to succeed within expiry time')
        expect( Time.now - start_time ).to be_within(0.1).of(10)
      end
    end

  end

end