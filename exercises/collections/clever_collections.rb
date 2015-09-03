require 'pry'

prices = {
      'orange' => 10,
      'apple' => 20,
      'bread' => 100,
      'tomato' => 25,
      'cereal' => 234
}

shopping_list = [:orange, :apple, :apple, :cereal, :bread]

#TODO - print out in pounds and pence the total for the shopping list

cost = shopping_list.map { |item| prices[item.to_s] }.reduce(:+)

puts "The price of the shopping list is: £#{'%.2f' % cost}."

