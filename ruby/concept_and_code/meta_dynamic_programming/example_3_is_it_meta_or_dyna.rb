# Runtime dispatch by name

# class Calculator
#   def add(a, b); a + b end
#   def sub(a, b); a - b end
#   def mul(a, b); a * b end
# end

# calc = Calculator.new
# operation = "mul"

# puts calc.public_send(operation, 2, 3)

=begin
This specific code is an example of dynamic programming, but it serves as a stepping stone toward metaprogramming.
Here is the exact breakdown of why:
## 🏃 Why it is Dynamic Programming

* Runtime Decision: The program decides which method to call while it is running, based on the string value of the operation variable.
* Late Binding: Ruby does not check if mul exists when you write the code; it evaluates it at the exact moment public_send executes.
* No Code Generation: You are not writing code that writes code. You are simply calling a hardcoded, existing method (mul) using a dynamic name.

## 🪄 How it bridges into Metaprogramming
While this snippet itself is just dynamic invocation, public_send is a core tool used inside metaprogramming.
For example, it becomes metaprogramming if you use it to dynamically loop over data and generate results on the fly without hardcoding the methods:

# Metaprogramming variant: Looping through data to dynamically call methods
[:add, :sub, :mul].each do |op|
  puts "Result of #{op}: #{calc.public_send(op, 6, 7)}"end

------------------------------
=end

# Converting it into pure metaprogramming paradigm
class Calculator
  OPERATIONS = { add: :+, sub: :-, mul: :* }

  OPERATIONS.each do |name, operator|
    define_method(name) do |a, b|
      a.public_send(operator, b)
    end
  end 
end

calc = Calculator.new
operation = "add"
puts calc.public_send(operation, 2, 3)
