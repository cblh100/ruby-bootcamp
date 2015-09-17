class Call

  attr_accessor :called

  def initialize(called, &block)
    raise ArgumentError, 'You must pass a block to initialize the Call' if !block_given?
    @called = called
    instance_eval &block
  end

  VALID_ATTRIBUTES = %w(date duration cost)

  VALID_ATTRIBUTES.each do |name|
    define_method(name) do |value = nil|
      return instance_variable_get("@#{name}") unless value
      instance_variable_set("@#{name}", value)
    end
  end

end