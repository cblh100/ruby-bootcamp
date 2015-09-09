require_relative 'talker'
require_relative 'mover'

module RubyBootcamp
  module Modules
    class Robot
      include Talker
      include Mover

      attr_reader :position

      def initialize(name)
        @name = name

        @greetings = GREETINGS
        @goodbyes = GOODBYES
        @position = {logitude: 0, lattitude: 0 }
      end

      def tell_me_the_time
        say "#{greeting}, the time is #{Time.now}"
      end

      def fire_laser
        shout 'firing laser'
      end
    end
  end
end
