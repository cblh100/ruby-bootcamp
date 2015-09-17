require 'spec_helper'

shared_examples 'a talker' do

  let(:name) { 'Mr Chatty' }
  let(:talker) { described_class.new(name) }

  let(:greetings) { ['hello', 'good day', "what's up", 'yo', 'hi', 'sup', 'hey'] }
  let(:goodbyes) { ['goodbye', 'see you later', 'in a while crocodile', 'l8rs', 'bye for now'] }

  it 'is a talker' do
    expect(talker).to be_kind_of(RubyBootcamp::Modules::Talker)
  end

  describe '#say' do
    it 'outputs the message to the screen in lowercase' do
      expect { talker.say 'HELLO' }.to output("hello\n").to_stdout
    end
  end

  describe '#shout' do
    it 'outputs the message to the screen in uppercase' do
      expect { talker.shout 'hello' }.to output("HELLO!!!\n").to_stdout
    end
  end

  describe '#greeting' do
    it 'returns a random greeting' do
      expect(talker.greeting).to satisfy { |word| greetings.include? word }
    end
  end

  describe '#farewell' do
    it 'returns a random farewell' do
      expect(talker.farewell).to satisfy { |word| goodbyes.include? word }
    end
  end

end

describe RubyBootcamp::Modules::Person do

  it_behaves_like 'a talker'

end

describe RubyBootcamp::Modules::Robot do

  it_behaves_like 'a talker'

end
