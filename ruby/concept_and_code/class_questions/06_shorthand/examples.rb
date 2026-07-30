# 1. Factorial
puts "----------------------------Factorial-------------------------------"
puts (1..5).reduce(1, :*)
puts (1..5).reduce(:*) || 1

# 2. Fibonacci
puts "----------------------------fibonacci-------------------------------"
# Version: 1
def fib(n)
  (n-1).times.reduce([0, 1]) {|(a, b), _| [b, a+b]}.first
end
puts fib(5)
# arr = [1,2,3] 
# puts 1.times.reduce(arr, :*) # Won't work
# times => returns an enumerator
e = 3.times
p e.to_a
# that why
1.times # => gives only one value which is 0
# now internally .reduce(arr, :*) works like
1.times.reduce() {|accumulator, value| accumulator * value}
# where accumulator = [1,2,3] and value = 0 => [1,2,3] * 0 => Array * Integer => Mean repeat the array => [] => puts [] => Means prints each element of array, since array is empty nothing prints => Then puts itself returns and output nil in IRB
# Note valid destructuring
arr = [1,2,3]
(a, b) = arr # and not arr = (a, b)

#Version 2: Uses a bit less object allocation and more readable
def fib_v2(n)
  a = 0
  b = 1

  (n-1).times do
    a, b = b, a + b
  end

  b
end
puts fib_v2(5)

# 3. Recursive Fibonacci
puts "----------------------------Recursive Fibonacci-------------------------------"

def recur_fib(n)
  n > 2 ? recur_fib(n-1) + recur_fib(n-2) : n == 1 ? 0 : 1
end
puts recur_fib(5)

# 4. Palindrom
puts "----------------------------Palindrom-------------------------"
# String
def check_s(s)
  puts s == s.reverse
  # String ignoring cases and space
  puts s.downcase.gsub(/\W/, '') == s.downcase.gsub(/\W/, '').reverse
end
check_s("aba")
# Number
def check_n(n)
  n.to_s == n.to_s.reverse
end
puts check_n(121)
=begin
Note: n = 123 => n.to_s! => won't work as you can't change number to string 
=end
# 5. Armstrong
puts "----------------------------Armstrong-------------------------"
def Armstrong(n)
  # first version:
  # n_s = n.to_s
  # size = n_s.length
  # output = n_s.each_char.reduce(0) {|accumulator, char| accumulator + char.to_i ** size}
  # output == n 
  # second version:
  # n == n.to_s.each_char.reduce(0) {|accumulator, char| accumulator + char.to_i ** n.to_s.length} # can use .chars too but it creates extra array so not good if we prioritize complexity
  # Third version:
  # puts n.digits {|d| d**n.digits.length}.sum => Gives 9 not 153 because .digits ignores any block which comes after it, so
  # n == n.digits {|d| d**n.digits.length}.sum => is a buggy code.
  # To fix it we can use .sum which accpets a block before summing elements
  puts n.digits.sum {|d| d**n.digits.length}
  n == n.digits.sum {|d| d**n.digits.length}
end
puts Armstrong(153)

# 5. Prime Number
puts "----------------------------Prime Number-------------------------"
def check_prime(n)
  # Version 1: This works but creates a massive array of true and false
  # (2..n-1).map {|i| n % i == 0 ? false : true}.include?(false) == false
  # Version 2
  return false if n <= 1
  (2..Integer.sqrt(n)).none? {|i| n % i == 0}
end
p check_prime(17.7)

# 5. Counting substring
puts "----------------------------Counting Substring-------------------------"
puts "a".count("a") # 1
puts "a".count("b") # 0
puts "aa".count("a") # 2
puts "ab".count("ab") # 2
puts "aba".count("a-b") # 3
puts "a".count("aa") # 1
puts "ab".count("a", "b") # 0 => a, b are different sets in .count so we take intersection of both which results in no character matching
puts "abn".count("an", "nb") # 1
puts "aaaaa".count("aa") # 5 => .cunt consider passed element as sets so "aa" becaomes "a" in .count
# So .count doesn't really count substring, just each character. To count substring use scan
puts "aaaa".scan("a").length # 4
puts "aaaa".scan("aa").length # 2
puts "aaaaa".scan("aa").length # 2

# 5. Counting character
puts "----------------------------Counting character-------------------------"