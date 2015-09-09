class CallCharges

  attr_accessor :calls

  def initialize(&block)
    raise ArgumentError, 'You must pass a block to initialize the CallCharges' if !block_given?
    @calls = []
    instance_eval &block
  end

  def call(called, &block)
    calls << Call.new(called, &block)
  end

end