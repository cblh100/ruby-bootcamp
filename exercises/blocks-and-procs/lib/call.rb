require 'attribute'

class Call
  extend Attribute

  attr_accessor :called

  def initialize(called, &block)
    raise ArgumentError, 'You must pass a block to initialize the Call' if !block_given?
    @called = called
    instance_eval &block
  end

  attribute :date, :duration, :cost

end