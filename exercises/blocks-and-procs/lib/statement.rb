require 'json'
require 'attribute'

class Statement
  extend Attribute

  def initialize(&block)
    raise ArgumentError, 'You must pass a block to initialize the Statement' if !block_given?
    instance_eval &block
  end

  attribute :date, :due, :from, :to, :total

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



