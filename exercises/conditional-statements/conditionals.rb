require 'pry'

def print_for(nums)
  for i in 0..(nums.length - 1)
    puts nums[i]
  end
end

def print_while(nums)
  i = 0
  while i < nums.length
    puts nums[i]
    i += 1
  end
end

def print_recur(nums)
  if nums.length != 0
    puts nums[0]
    print_recur(nums.drop(1))
  end
end

numbers = [1,2,3,4,5,6,7,8,9]

print_for(numbers)
print_while(numbers)
print_recur(numbers)

def combine_lists(list1, list2)
  list1.zip(list2).flatten
end

list_one = ['a', 'b', 'c']
list_two = [1, 2, 3]

combined_list = combine_lists(list_one, list_two)

puts combined_list

def fib(num)

  if num == 0
    []
  elsif num == 1
    [0]
  elsif num == 2
    [0, 1]
  else
    fib_list = fib(num - 1)
    fib_list.push(fib_list[-2] + fib_list[-1] )
 end

end

first_100 = fib(100)

binding.pry

def add_numbers(nums)

  if nums.length == 0 
    0
  else
    nums[0] + add_numbers(nums.drop(1))
  end

end



