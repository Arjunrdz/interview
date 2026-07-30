To prevent a LocalJumpError when a block is missing, check if a block exists before executing it. Ruby provides a built-in method called block_given? specifically for this purpose.
Here are the two best ways to handle this.
## Option 1: Use block_given? (Recommended)
Wrap your yield statement in an if block_given? condition. If no block is passed, the method will safely skip the yield and return nil.

```
irb(main):001> def hey
irb(main):002*   yield if block_given?
irb(main):003> end
=> :hey
irb(main):004> hey
=> nil
irb(main):005> hey { puts "Hello!" }
Hello!
=> nil
```

## Option 2: Use an Explicit Block Argument
Capture the block as a named parameter using the & operator, then use the safe navigation operator (&.) to call it only if it is present.

```
irb(main):001> def hey(&block)
irb(main):002*   block&.call
irb(main):003> end
=> :hey
irb(main):004> hey
=> nil
irb(main):005> hey { puts "Hello!" }
Hello!
=> nil
```

## Option 3: Inline Rescue
```
def hey
  yield rescue "No block was provided!"
end

hey 
# => "No block was provided!"
```

## Option 4: Standard Begin/Rescue
```
def hey
  begin
    yield
  rescue LocalJumpError
    puts "Caught the error: moving on without a block."
  end
end

hey
# Output: Caught the error: moving on without a block.
```

## Performance and Style Benefits:
- No Performance Penalty Raising and rescuing errors in Ruby is slow because it has to generate a stack trace. block_given? is a simple boolean check, making it highly efficient.
- Idiomatic Ruby: This is the standard, cleanest way Ruby developers handle optional blocks.
- Flexible Control Flow: You can use it to provide alternative logic or default return values when a block is omitted.


[1] [https://medium.com](https://medium.com/@kylelzk/demystifying-yield-in-ruby-45e6c78ef563)
