require 'pry'
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

=begin
Given the following price list and shopping list print out the total cost of 
the shopping list in pounds and pence
=end 

prices = Hash[*price_list.split.reject { |it| it == '=' }]
#binding.pry

prices.each { |k,v|
  prices[k] = ( /^(\d+)p$/.match(v) { |m| m[1].to_i } or
                /^£(\d+).(\d+)$/.match(v) { |m| (m[1].to_i * 100) + m[2].to_i } or
                0 )
}

cost = shopping_list.split.map { |item| prices[item] or 0 }.reduce(:+)

puts "The price of the shopping list is: £#{'%.2f' % cost}."
