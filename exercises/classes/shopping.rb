class Till

  attr_reader :prices, :total

  def initialize(price_list)
    @prices = parse_price_list(price_list)
    @total = 0
  end

  def parse_price_list(price_list)
    prices = convert_list_to_hash(price_list)
    convert_prices_to_pence(prices)
  end

  def convert_list_to_hash(list)
    Hash[*list.split.reject { |it| it == '=' }]
  end

  def convert_prices_to_pence(prices)
    converted_prices = {}
    prices.each { |item,amount|
      converted_prices[item] = (parse_as_pence(amount) or parse_as_pounds(amount) or 0)
    }
    converted_prices
  end

  def parse_as_pence(amount)
    /^(\d+)p$/.match(amount) { |m| m[1].to_i }
  end

  def parse_as_pounds(amount)
    /^£(\d+).(\d+)$/.match(amount) { |m| (m[1].to_i * 100) + m[2].to_i }
  end

  def <<(item)
    @total += prices[item]
  end

end

class Shopping

  attr_reader :items

  def initialize(list)
    @items = parse_shopping_list(list)
  end

  def <<(item)
    @items << item
  end

  def parse_shopping_list(list)
    list.split.drop(1)
  end

end

def scan_shopping(till, shopping)
  shopping.items.each { |item| till << item }
end

price_list = "orange = 10p apple = 20p bread = £1.10 tomato = 25p cereal = £2.34"

shopping_list=<<LIST
 list
 orange
 apple
 apple
 orange
 tomato
 cereal
 bread
 orange
 tomato
LIST

till = Till.new(price_list)

shopping = Shopping.new(shopping_list)

scan_shopping(till, shopping)

puts till.total

