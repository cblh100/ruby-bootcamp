require 'spec_helper'

describe RubyBootcamp::Modules::Person do

  subject(:person) { described_class.new('person') }

  describe '#tell_me_the_time' do

    it 'says a greeting and doesn\'t tell the time' do
      allow(subject).to receive(:greeting).and_return('HELLO')
      expect { subject.tell_me_the_time }.to output("hello, sorry i'm not a robot and i don't have a watch\n").to_stdout
    end

  end

end

