require 'json'

class Statement

  def initialize(&block)
    raise ArgumentError, 'You must pass a block to initialize the Statement' if !block_given?
    instance_eval &block
  end

  def date(date = nil)
    return @date unless date
    @date = date
  end

  def due(due = nil)
    return @due unless due
    @due = due
  end

  def from(from = nil)
    return @from unless from
    @from = from
  end

  def to(to = nil)
    return @to unless to
    @to = to
  end

  def total(total = nil)
    return @total unless total
    @total = total
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



