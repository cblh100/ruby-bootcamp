require 'spec_helper'

GREETINGS = ['hello', 'good day', "what's up", 'yo', 'hi', 'sup', 'hey']
GOODBYES = ['goodbye', 'see you later', 'in a while crocodile', 'l8rs', 'bye for now']

shared_examples 'a talker' do

  let(:name) { 'Mr Chatty' }
  let(:talker) { described_class.new(name) }

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
      expect(talker.greeting).to satisfy { |word| GREETINGS.include? word }
    end
  end

  describe '#farewell' do
    it 'returns a random farewell' do
      expect(talker.farewell).to satisfy { |word| GOODBYES.include? word }
    end
  end

end

describe RubyBootcamp::Modules::Person do

  it_behaves_like 'a talker'

end

describe RubyBootcamp::Modules::Robot do

  it_behaves_like 'a talker'

end
