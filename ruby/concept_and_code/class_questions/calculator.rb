# def perform_action(n1, n2, operation_type)
#   case operation_type
#   when :add
#     Proc.new {puts n1+n2}
#   when :subtract
#     Proc.new {puts n1-n2}
#   when :divide
#     Proc.new {puts n1/n2}
#   when :multiply
#     Proc.new {puts n1*n2}
#   else
#     raise ArgumentError, "Define a valid operation type."
#   end
# end

# addition = perform_action(1, 2, :add)
# addition.call()

# subtraction = perform_action(1, 2, :subtract)
# subtraction.call()

# division = perform_action(1, 2, :divide)
# division.call()

# multiplication = perform_action(1, 2, :multiply)
# multiplication.call()

# puts "Enter two number:"
# x = gets.chomp.to_i
# puts x
# y = gets.chomp.to_i
# puts y

# puts "Enter operation => add, subtract, multiply, divide"
# operation_type = gets.chomp.to_sym

# def perform_action(n1, n2, operation_type)
#   calculation = case operation_type
#     when :add
#       -> (a, b) {a + b}
#     when :subtract
#       Proc.new {|a, b| a - b}
#     when :multiply
#       -> (a, b) {a * b}
#     when :divide
#       Proc.new { |a,b|
#         raise "Cannot divide by 0" if b == 0
#         a.to_f / b
#       }
#     else
#       raise ArgumentError, "Pass a valid operation type."
#   end
#   calculation.call(n1, n2)
# end

# result = perform_action(1,2,:add)
# p result * 5
# puts perform_action(x,y,operation_type)
# puts perform_action(1,2,:subtract)
# puts perform_action(1,2,:divide)
# puts perform_action(1,2,:multiply)

#calculator using procs

#taking input from the user
# puts "Enter two numbers"
# a = gets.to_i 
# puts a
# b = gets.to_i 
# puts b

# puts "Enter the operation you want to perform: add, subtract, multiply, divide"
# operation = gets.chomp

# @add = Proc.new { |a, b| puts a + b }
# @subtract = Proc.new { |a, b|puts a - b }  
# @multiply = Proc.new { |a, b| puts a * b }
# @divide = Proc.new { |a, b| puts a / b }

# result = @add.call(1,2)
# p result
# puts result * 5
# def calculate(a, b,operation)
#   case operation
#   when "add"
#     @add.call(a, b)
#   when "subtract"
#     @subtract.call(a, b)
#   when "multiply"
#     @multiply.call(a, b)
#   when "divide"
#     @divide.call(a, b)
#   else
#     puts "Invalid operation"  
#   end
#   #operation.call(a, b)
# end

# calculate(a, b, operation)




def calc(a,b,op)
  op.call(a,b)
end

add = Proc.new do |a,b|
  puts a + b
end

sub = Proc.new do |a,b|
  puts a - b
end

mul = Proc.new do |a,b|
  puts a * b
end

div = Proc.new do |a,b|
  puts a / b
end

added = calc(1,2,add)
p added*5
calc(132,100,sub)
calc(10,20,mul)
calc(625,25,div)