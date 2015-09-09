module RubyBootcamp
  module Modules
    module Talker

      GREETINGS = ['hello', 'good day', "what's up", 'yo', 'hi', 'sup', 'hey']
      GOODBYES = ['goodbye', 'see you later', 'in a while crocodile', 'l8rs', 'bye for now']

      def say (message)
        puts message.downcase
      end

      def shout(message)
        puts "#{message.upcase}!!!"
      end

      def greeting
        @greetings.sample
      end

      def farewell
        @goodbyes.sample
      end

    end
  end
end