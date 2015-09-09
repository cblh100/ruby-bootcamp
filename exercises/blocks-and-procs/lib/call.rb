class Call

  attr_accessor :called

  def initialize(called, &block)
    raise ArgumentError, 'You must pass a block to initialize the Call' if !block_given?
    @called = called
    instance_eval &block
  end

  def date(date = nil)
    return @date unless date
    @date = date
  end

  def duration(duration = nil)
    return @duration unless duration
    @duration = duration
  end

  def cost(cost = nil)
    return @cost unless cost
    @cost = cost
  end

end