In Ruby, a lambda is actually a specific type of Proc object, but they have two vital differences in how they behave: argument strictness (arity) and how they handle the return keyword. [1, 2] 
------------------------------
## Summary Table

| Feature | Proc | Lambda |
|---|---|---|
| Syntax | Proc.new { ... } or proc { ... } | lambda { ... } or -> { ... } |
| Argument Checking | Generous (ignores extra, sets missing to nil) | Strict (raises ArgumentError) |
| return Behavior | Exits from the enclosing method | Exits only from the lambda itself |

------------------------------
## 1. Argument Checking (Arity)
Lambdas treat arguments like standard Ruby methods, whereas Procs are much more flexible. [2, 3] 

* Lambda: If you pass the wrong number of arguments, it immediately throws an error.
* Proc: If you pass too many arguments, it ignores the extra ones. If you pass too few, it assigns nil to the missing variables. [4, 5] 

```
# Proc behavior
my_proc = Proc.new { |x, y| "x: #{x}, y: #{y}" }
my_proc.call(1)          # => "x: 1, y: " (y becomes nil)
my_proc.call(1, 2, 3)    # => "x: 1, y: 2" (3 is ignored)

# Lambda behavior
my_lambda = ->(x, y) { "x: #{x}, y: #{y}" }
my_lambda.call(1)        # => ArgumentError (wrong number of arguments)
my_lambda.call(1, 2, 3)  # => ArgumentError (wrong number of arguments)
```

------------------------------
## 2. The return Keyword Behavior
This is the most critical logic difference when nesting them inside methods. [2] 

* Lambda: The return keyword stops the lambda code and passes control right back to the calling method.
* Proc: The return keyword forces the entire enclosing method to exit right then and there. [1, 4, 6, 7] 

```
def test_lambda
  my_lambda = -> { return "Lambda exit" }
  my_lambda.call
  "Method finished successfully"end

puts test_lambda # => "Method finished successfully"# (The lambda returned, but the method kept going)

def test_proc
  my_proc = Proc.new { return "Proc exit" }
  my_proc.call
  "Method finished successfully"end

puts test_proc # => "Proc exit"# (The proc killed the execution of the entire test_proc method)
```

------------------------------
## Which one should you use?
As a general best practice, default to using lambdas. Because they behave like normal Ruby methods, they are far more predictable, safer to debug, and won't unexpectedly hijack your method's control flow. [2, 3, 8, 9] 


[1] [https://www.youtube.com](https://www.youtube.com/watch?v=jS1hbXSuiTo)
[2] [https://rubylearning.com](https://rubylearning.com/guides/ruby-lambda-proc.html)
[3] [https://www.codewithjason.com](https://www.codewithjason.com/the-difference-between-procs-and-lambdas-in-ruby/)
[4] [https://stackoverflow.com](https://stackoverflow.com/questions/1740046/whats-the-difference-between-a-proc-and-a-lambda-in-ruby)
[5] [https://www.reddit.com](https://www.reddit.com/r/ruby/comments/vjmxhz/proc_and_lambda_behavior/)
[6] [https://dev.to](https://dev.to/renatamarques97/understanding-blocks-procs-and-lambdas-in-ruby-2j38)
[7] [https://www.youtube.com](https://www.youtube.com/watch?v=Dh3cSYjHITI&t=630)
[8] [https://www.rubyguides.com](https://www.rubyguides.com/2016/02/ruby-procs-and-lambdas/)
[9] [https://www.codewithjason.com](https://www.codewithjason.com/the-difference-between-procs-and-lambdas-in-ruby/)
