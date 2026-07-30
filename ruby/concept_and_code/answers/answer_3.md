# Answer 3:
# Ruby as a Message-Passing Language

Yes, Ruby is fundamentally a **message-passing language**. Inheriting this paradigm from Smalltalk, every method call in Ruby is a message sent to an object. Instead of statically binding a method to an object at compile-time, Ruby looks up the method dynamically at runtime in response to the message.

## Key Characteristics

### 1. Dynamic Dispatch

When you write `object.method_name`, Ruby doesn't just call a function. It dynamically packages `method_name` into a message and asks the object if it knows how to handle it.

### 2. Explicit Sending

You can explicitly send messages using the built-in `send` method:

```ruby
object.send(:method_name)
```

This allows you to determine which method to call at runtime dynamically.

### 3. `method_missing`

If an object receives a message it does not recognize, Ruby doesn't immediately crash. It instead intercepts the failed message via the `method_missing` hook, allowing developers to create highly flexible, metaprogramming-heavy code.

```ruby
class DynamicClass
  def method_missing(name, *args)
    puts "You called: #{name} with #{args}"
  end
end

obj = DynamicClass.new
obj.anything  # => You called: anything with []
```

## Example

### With explicit sending (send): No if/else hell
```
class LightBulb
  def turn_on
    "💡 Light is now ON."
  end

  def turn_off
    "🌑 Light is now OFF."
  end

  def blink
    "✨ Light is blinking."
  end
end

bulb = LightBulb.new

# A continuous loop keeps the program running
loop do
  print "Enter command (turn_on, turn_off, blink, or exit): "
  user_command = gets.chomp # Captures user input at runtime

  break if user_command == "exit"

  # respond_to? dynamically checks if the method exists on the object
  if bulb.respond_to?(user_command)
    puts bulb.send(user_command)
  else
    puts "❌ Unknown command: '#{user_command}'. Please try again."
  end
end

puts "Goodbye!"

```

### With dynamic dispatch (calling with .): If/else hell
```
class LightBulb
  def turn_on
    "💡 Light is now ON."
  end

  def turn_off
    "🌑 Light is now OFF."
  end

  def blink
    "✨ Light is blinking."
  end
end

bulb = LightBulb.new

loop do
  print "Enter command (turn_on, turn_off, blink, or exit): "
  user_command = gets.chomp 

  break if user_command == "exit"

  # Standard Dynamic Dispatch version requires explicit mapping:
  case user_command
  when "turn_on"
    puts bulb.turn_on
  when "turn_off"
    puts bulb.turn_off
  when "blink"
    puts bulb.blink
  else
    puts "❌ Unknown command: '#{user_command}'. Please try again."
  end
end

puts "Goodbye!"

```

### How to protect program by preventing users from calling intermal and private ruby method while using send: We use public_send
```
class LightBulb
  def turn_on
    "💡 Light is now ON."
  end

  def turn_off
    "🌑 Light is now OFF."
  end

  def blink
    "✨ Light is blinking."
  end
end

bulb = LightBulb.new

# Define an explicit list of allowed commands for total control
ALLOWED_COMMANDS = ["turn_on", "turn_off", "blink"].freeze

loop do
  print "Enter command (turn_on, turn_off, blink, or exit): "
  user_command = gets.chomp 

  break if user_command == "exit"

  # Step 1: Ensure the command is explicitly whitelisted 
  # Step 2: Ensure the object publicly responds to it
  if ALLOWED_COMMANDS.include?(user_command) && bulb.respond_to?(user_command)
    
    # public_send will fail with a NoMethodError if the method is private/protected
    puts bulb.public_send(user_command)
    
  else
    puts "❌ Access Denied or Unknown command: '#{user_command}'."
  end
end

puts "Goodbye!"

```

## Further Exploration

- **Dynamic execution** — using `send` to call methods whose names are determined at runtime
- **`method_missing`** — handling unknown messages for proxy objects, DSLs, and metaprogramming
- **Comparison with Java/Python** — Java uses static dispatch (resolved at compile-time); Python uses attribute lookup but lacks a native `method_missing` equivalent (`__getattr__` is the closest analog)

# Answer