=begin
Ruby does not support method overloading. If multiple methods are defined with the same name, the last definition replaces the previous ones. But, we can achieve similar behavior using default arguments, variable-length arguments (*args), or keyword arguments.
=end

# Using *args
class Calculator
  def add(*args)
    args.sum
  end
end

calc = Calculator.new

puts calc.add(10, 20)         # 30
puts calc.add(10, 20, 30)     # 60
puts calc.add(5)              # 5

# Using default argument
class Greeting
  def greet(name = "Guest")
    puts "Hello, #{name}!"
  end
end

g = Greeting.new

g.greet          # Hello, Guest!
g.greet("Alice") # Hello, Alice!

# If you try to define multiple methods with the same name, only the last one exists.
class Demo
  def show
    puts "No arguments"
  end

  def show(name)
    puts "Hello #{name}"
  end
end

Demo.new.show
# Error: wrong number of arguments (given 0, expected 1)