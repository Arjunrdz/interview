=begin
yield is a Ruby keyword used inside a method to transfer control to the block that was passed to that method.
Its purpose is to let methods accept and execute blocks without requiring an explicit block parameter.
=end
def greet
  yield
end

p greet {puts "Hello"} # => Hello \n nil
p greet {"Hello"} # => "Hello"
greet {puts "Hello"} # => Hello

# yield is central to Ruby’s block-oriented style, especially for iterators, resource management, and DSLs.

# Checking whether a block was given:
def method_name
  yield if block_given?
end

# Capturing the return value of the block:
def method_name
  result = yield
  result
end

# example
def greet
  yield("Alice")
end

greet { |name| puts "Hello #{name}" }

# yielding multiple times
def three_times
  # yield(1)
  # yield(2)
  # yield(3)
  p (1..3).map { |n| yield(n) } # => [nil, nil, nil] because return value of puts is nil
end

three_times { |number| puts number }

def three_times_corrected
  # yield(1)
  # yield(2)
  # yield(3)
  p (1..3).map { |n| yield(n*n) } # => [1, 4, 9], if you replace it with each the output would be: => (1..3)
end

three_times_corrected { |number| number }

# Returing values from the block
def compute
  result = yield(10)
  result * 2
end

p compute { |number| number + 5 }

# optional block
def notify(message)
  if block_given?
    yield(message)
  else
    puts(message)
    # message
  end
end

notify("Email Received")
notify("In yield") {|msg| puts "Block says: #{msg}"}

# resource management
def with_file(path, mode = "r")
  file = File.open(path, mode)
  yield(file)
ensure
  file&.close # Safe navigation operator or lonely operator
end

with_file("example.txt") do |file|
  puts file.read
end
=begin
The & character in file&.close is part of Ruby's Safe Navigation Operator (often called the "lonely operator").
It prevents your program from crashing with a NoMethodError if the file variable is nil.
## How It Works

* Without & (file.close): If the File.open call failed and raised an error before assigning anything to the file variable, file would be nil. Calling nil.close throws an undefined method error, hiding the real problem.
* With & (file&.close): Ruby checks if file is nil. If it is nil, it skips the method call and safely returns nil. If file is a real file object, it safely calls .close. [1, 2] 

## Why it is critical in an ensure block
The ensure block always runs, even if the code inside the main begin block crashes. [3] 
If File.open("example.txt") fails because the file does not exist, an exception is thrown immediately. Because it failed, the file variable is left as nil. The program then jumps straight to the ensure block. Thanks to file&.close, Ruby safely skips closing the non-existent file instead of crashing a second time. [4, 5, 6] 
## Quick Syntax Comparison

# Old Ruby syntax (longer)
file.close if file
# Modern Ruby syntax with Safe Navigation (shorter)
file&.close

Would you like to see how to rewrite this entire pattern using Ruby's native File.open block syntax, or explore how to handle specific file errors using rescue?

[1] [https://discourse.stonehearth.net](https://discourse.stonehearth.net/t/lua-script-check-if-file-exists-easy/1484)
[2] [https://diveintopython3.net](https://diveintopython3.net/files.html)
[3] [https://medium.com](https://medium.com/@aditya_shenoyy/understanding-with-and-context-manager-in-python-8169c8a70e13)
[4] [https://realjavaonline.com](http://realjavaonline.com/Files/dataio.php)
[5] [https://www.educative.io](https://www.educative.io/answers/how-to-file-handle-in-swift-using-filehandler)
[6] [https://docs.coronalabs.com](https://docs.coronalabs.com/guide/data/readWriteFiles/index.html)

=end