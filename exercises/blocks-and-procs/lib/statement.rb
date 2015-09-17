require 'json'

class Statement

  def initialize(&block)
    raise ArgumentError, 'You must pass a block to initialize the Statement' if !block_given?



    instance_eval &block
  end

  VALID_ATTRIBUTES = %w(date due from to total)

  VALID_ATTRIBUTES.each do |name|
    define_method(name) do |value = nil|
      return instance_variable_get("@#{name}") unless value
      instance_variable_set("@#{name}", value)
    end
  end

  def call_charges(&block)
    return @call_charges unless block_given?
    @call_charges = CallCharges.new(&block)
  end

  def to_json
    JSON.pretty_generate(
        {
            :statement => {
            :generated => @date,
            :due => @due,
            :period => { :from => @from, :to => @to },
            :total => @total,
            :callCharges =>
                { :calls => call_charges.calls.map do |call|
                  {
                      :called => call.called,
                      :date => call.date,
                      :duration => call.duration,
                      :cost => call.cost
                  }
                end
                }
            }
        })
  end

end



