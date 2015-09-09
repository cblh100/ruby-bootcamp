require_relative 'talker'
require_relative 'mover'

module RubyBootcamp
  module Modules
    class Person
      include Talker
      include Mover

      attr_reader :position

      def initialize(name)
        @name = name

        @greetings = GREETINGS
        @goodbyes = GOODBYES
        @position  = {logitude: 0, lattitude: 0 }
      end

      def tell_me_the_time
        say "#{greeting}, sorry I'm not a Robot and I don't have a watch"
      end

    end
  end
end
