prices = {
      'orange' => 10,
      'apple' => 20,
      'bread' => 100,
      'tomato' => 25,
      'cereal' => 234
} 

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

prices.default = 0

cost = shopping_list.split.map { |item| prices[item] }.reduce(:+)

puts "The price of the shopping list is: £#{'%.2f' % cost}."
