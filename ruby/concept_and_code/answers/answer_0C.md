To check the type of an object or variable in Ruby, call the .class method directly on the variable. [1, 2] 
Because Ruby is a dynamically typed language, variables themselves do not have strict types; instead, they point to objects that do. You can inspect, verify, or match these object types using several native approaches: [1, 3, 4, 5, 6] 
## 1. Find the Exact Class
Use .class to return the specific class name of the value stored in your variable. [1, 5] 

name = "Alice"
age = 30
items = [1, 2, 3]

puts name.class   # Output: String
puts age.class    # Output: Integer
puts items.class  # Output: Array

## 2. Check Inheritance and Mixins
Use .is_a?(ClassName) or .kind_of?(ClassName) to check if an object is an instance of a specific class or any of its parent classes. [1, 7, 8, 9] 

num = 5
# Integer is a subclass of Numeric
puts num.is_a?(Integer)  # Output: true
puts num.is_a?(Numeric)  # Output: true
puts num.is_a?(String)   # Output: false

## 3. Check for Strict Instances
Use .instance_of?(ClassName) if you want to verify that an object belongs exactly to that class, ignoring any inherited parent classes. [5, 9] 

num = 5

puts num.instance_of?(Integer)  # Output: true
puts num.instance_of?(Numeric)  # Output: false (even though it inherits from Numeric)

## 4. Check Capabilities (Duck Typing)
In idiomatic Ruby, it is often better to ask what an object can do rather than what it is. Use .respond_to?(:method_name) to check if the object supports a specific action. [1, 7, 10] 

# Checks if the variable can be safely converted into a string
puts name.respond_to?(:to_s)  # Output: true

## 5. Check in Case Statements
You can cleanly route your logic depending on the variable type by using standard case/when structures.

input = "Hello World"
case inputwhen String
  puts "It is a string!"when Integer
  puts "It is an integer!"else
  puts "Unknown type"end

If you are debugging your application, you can also use .inspect or the p command to quickly display both the object's value and structural clues in the terminal. [11, 12] 
If you tell me what specific logic you are trying to write or what problem you are debugging, I can show you the most idiomatic Ruby pattern to handle it.
