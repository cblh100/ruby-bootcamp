require 'spec_helper'
require 'timecop'

describe RubyBootcamp::Modules::Robot do

  subject(:robot) { described_class.new('robot') }

  describe '#tell_me_the_time' do

    it 'says a greeting and tells the time' do
      Timecop.freeze do
        time = Time.now
        allow(subject).to receive(:greeting).and_return('HELLO')
        expect { subject.tell_me_the_time }.to output("hello, the time is #{time}\n").to_stdout
      end
    end

  end

  describe '#fire_laser' do

    it 'shouts firing laser' do
      expect { subject.fire_laser }.to output("FIRING LASER!!!\n").to_stdout
    end

  end

end

