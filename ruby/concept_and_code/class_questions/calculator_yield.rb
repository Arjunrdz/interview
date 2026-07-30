# The issue is that yield only works inside a standard method defined with the def keyword.When you use define_method, you are writing code inside a block (do ... end). In Ruby, the yield keyword is syntactically illegal inside a block. Ruby's compiler looks at your code and says: "You are trying to yield, but you are not inside a standard def method definition."Because it violates Ruby's core language rules at the structural level, it throws a SyntaxError before the code even runs.

=begin => Version 1
class Calculator
  OPERATIONS = {add: :+, sub: :-, mul: :*, div: :/, mod: :%}
  OPERATIONS.each do |name, operator|
    define_method(name) do |n1, n2|
      # :name is a literal Symbol. Its value is always exactly the word "name"
      # So we use just name
      # name is a variable pointer. In the first loop iteration, it points to the symbol :add.
      # n1.call(n2)
      puts n1.send(operator, n2)
    end
  end
end

calc = Calculator.new
# operation = "+"

calc.add(2, 3)

=begin
In Ruby, numbers are not just raw data—they are objects. Because they are objects, operators like +, -, *, and / are actually methods (functions) belonging to those numbers.
Here is exactly how n1.send(:+, n2) works behind the scenes.
## 1. The Normal Way (Syntactic Sugar)
When you write this in Ruby:

5 + 3

Ruby looks at that and secretly rewrites it as a standard object method call:

5.+(3)

This means: "Call the method named + on the number object 5, and pass the number 3 as an argument."
Ruby allows you to drop the dot . and the parentheses () just to make the code easier for humans to read. This readability shortcut is called syntactic sugar.
## 2. What .send Does
Every object in Ruby has a built-in tool called .send.
The .send method allows you to look up and run a method by using its name as text (a Symbol or a String).
For example, these two lines do the exact same thing:

"hello".upcase          # Standard way -> returns "HELLO""hello".send(:upcase)   # Dynamic way  -> returns "HELLO"

## 3. Putting It Together: n1.send(:+, n2)
In your calculator code, the variables hold these values:

* n1 = 2
* operator = :+
* n2 = 3

When Ruby hits this line:

n1.send(operator, n2)

It replaces the variables with their actual values:

2.send(:+, 3)

This tells Ruby: "Find the method named :+ inside the number 2, and run it using 3 as the input."
Ruby executes 2.+(3), the addition happens, and it outputs 5.
## Why do this?
If you didn't use .send, you would have to write an if statement for every single math sign:

if operator == :+
  n1 + n2elsif operator == :-
  n1 - n2# ... and so on

.send lets you skip the if/else entirely. Ruby grabs whatever math symbol is passed in and executes it directly.
------------------------------
To make sure this clicks, let me know if you would like to:

* Try writing a regular def/end method that uses .send to see it in a simpler environment
* Look at how Symbols (the words starting with colons like :+) differ from normal text strings
* See another example of .send using text or strings instead of numbers



=end

#---------------------------------------------------------------------------------------------------------------
# Using yield
# 
#Yield must be used inside a method, in bare class it gives LocalJumpError

# class Calculator
#   OPERATIONS = {add: :+, sub: :-, mul: :*, div: :/, mod: :%}
#   OPERATIONS.each do |name, operator|
#     define_method(:name) do |n1, n2|
#       yield # Error => Check Q0 in current folder
#     end
#   end
# end

# calc = Calculator.new
# calc.add(1,2)

# Version 2
# class Calculator
#   OPERATIONS = { add: :+, sub: :-, mul: :*, div: :/, mod: :% }

#   OPERATIONS.each do |name, operator|
#     define_method(name) do |n1, n2, &block|
#       # if block_given?
#         # yield passes control and data to the block
#         # puts yield(operator, n1, n2) => SyntaxError
#         # define_method takes a Proc as its method body.
#         # yield only works in a regular method definition (def ... end), where Ruby has an implicit block associated with the method call.
#         # A Proc has no implicit block to yield to, so yield and block_given? are unavailable there.
#         # To correct it we have to capture the block and convert it to proc and that's what define method wants
#       if block
#         puts block.call(operator, n1, n2)
#       else
#         puts "Error: No block provided for calculation"
#       end
#     end
#   end
# end

# calc = Calculator.new

# calc.add(2, 3) do |op, num1, num2|
#   num1.public_send(op, num2)
# end

# calc.sub(10, 4) do |op, num1, num2|
#   num1.send(op, num2)
# end

# Version 3: Both types of block works and operator is ignored when not provided
# class Calculator
#     OPERATIONS = {add: :+, sub: :-, mul: :*, div: :/, mod: :%}
#     OPERATIONS.each do |name, operator|
#         define_method(name) do |a, b, &block|
#             if block
#                 block.call(a, b, operator)
#             else
#                 puts "Erro: No block provided"
#             end
#         end
#     end
# end

# calc = Calculator.new
# calc.add(2, 3)  do |a,b,op|
#     puts a.public_send(op, b)
# end
# calc.mul(2,3)   {|a, b| puts a * b} 
# calc.div(2,3)   {|a, b| puts a / b}
# calc.sub(2,3)   {|a, b| puts a - b}
# calc.mod(2,3)   {|a, b| puts a % b}

# Version 4: Optimized version of Version 3
class Calculator
    OPERATIONS = {add: :+, sub: :-, mul: :*, div: :/, mod: :%}
    OPERATIONS.each do |name, operator|
        define_method(name) do |a, b, &block|
            if block
              if block.arity >= 3
                block.call(a, b, operator)
              else
                block.call(a, b)
              end
            else
              puts "Error: No block provided"
            end
        end
    end
end

calc = Calculator.new
calc.add(2, 3)  do |a,b,op|
    puts a.public_send(op, b)
end
calc.mul(2,3)   {|a, b| puts a * b} 
calc.div(2,3)   {|a, b| puts a / b}
calc.sub(2,3)   {|a, b| puts a - b}
calc.mod(2,3)   {|a, b| puts a % b}

# class Calculator
#   def calculate(num1, num2)
#     if block_given?
#       puts "Result = #{yield(num1, num2)}"
#     else
#       puts "Please provide a block."
#     end
#   end
# end

# calc = Calculator.new

# calc.calculate(10, 5) { |a, b| a + b }
# calc.calculate(10, 5) { |a, b| a - b }
# calc.calculate(10, 5) { |a, b| a * b }
# calc.calculate(10, 5) { |a, b| a / b }
# calc.calculate(10, 5) { |a, b| a % b }
# 

# class Area
#   def square(side)
#     puts yield(:square, side)
#   end

#   def rectangle(length, width)
#     puts yield(:rectangle, length, width)
#   end

#   def circle(radius)
#     puts yield(:circle, radius)
#   end
# end

# area = Area.new

# area.square(5) do |shape, side|
#   "#{shape}: #{side**2}"
# end

# area.rectangle(10, 4) do |shape, l, w|
#   "#{shape}: #{l * w}"
# end

# area.circle(7) do |shape, r|
#   "#{shape}: #{Math::PI * r**2}"
# end