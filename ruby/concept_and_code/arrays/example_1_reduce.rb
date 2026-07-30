# Alias of inspect

=begin => Syntax
collection.reduce(initial_value) do |accumulator, element|
  # return new accumulator
end
=end

p [1,2,3].reduce {|sum, n| sum + n}

=begin => Sum is initially zero here?
No, sum is not initially zero.
When you do not pass an explicit starting argument to reduce (or inject), Ruby automatically sets the accumulator (sum) to the first element of the collection, and the loop starts iterating from the second element.
Here is exactly how your block executed step-by-step:
## Iteration Trace for [1, 2, 3].reduce

   1. Initial Setup:
   * sum is set to 1 (the first element).
      * n takes 2 (the second element).
   2. First Loop:
   * 1 + 2 equals 3.
      * sum becomes 3.
   3. Second Loop:
   * n takes 3 (the third element).
      * 3 + 3 equals 6.
   4. Final Return: 6

------------------------------
## How to set the initial value to Zero
If you want sum to explicitly start at 0, you must pass 0 as an argument to the reduce method.

[1, 2, 3].reduce(0) { |sum, n| sum + n }# => 6

## Why does this distinction matter?
If you are just adding numbers, the result (6) looks identical. However, starting without an argument can cause unexpected crashes or bugs if your array is empty or contains non-numeric data types.

* Empty Array without argument: [].reduce { ... } returns nil.
* Empty Array with argument (0): [].reduce(0) { ... } returns 0.

## Pro Tip: The Shorthand Way
In Ruby, you don't even need the block if you are just performing a standard math operation. You can pass the symbol of the method you want to call directly:

[1, 2, 3].reduce(:+)# => 6

To see how this behaves in edge cases, let me know:

* Do you want to see what happens when you use reduce on an array of hashes or strings?
* Are you trying to use reduce to group data or build a custom data structure?
* Do you want to know the difference between reduce and each_with_object?

=end

p [1,2,3].reduce(-1) {|sum, n| sum + n}

p [1,2,3].reduce(:+)

# Flatten array
array = [[1,2], [3], [4,5]]
# Error code: Due to precedance issue
p array.reduce() do |acc, ele| 
  acc + ele
end
# Fixed
p array.reduce(:+) do |acc, ele| 
  acc + ele
end
# Fixed
p (array.reduce([]) do |acc, ele| # will work without [] too
  acc + ele
end)
# Fixed
p array.reduce([]) {|acc, ele| acc + ele}

=begin => Precedance

In Ruby, the confusion comes from a hidden clash between how methods grab their arguments and how blocks attach to methods.
Here is exactly why that error happens.
## 1. The Precedence Rule

* Curly braces { ... } have high precedence. They bind tightly to the method directly to their left.
* do ... end has low precedence. It binds loosely and prefers to attach to the very first method call in the line.

## 2. What Ruby Thinks You Wrote
When you write p array.reduce([]) do ... end, Ruby reads the line from left to right. Because do ... end has low precedence, it ignores reduce and attaches itself to p.
Ruby interprets your code as if you wrote this:

# This is how Ruby sees your code:
p(array.reduce([])) do |acc, ele|
  acc + eleend

Because of this, array.reduce([]) executes completely on its own first, without any block attached to it.
## 3. Why the Error Message Happens
When reduce runs without a block, Ruby expects you to pass a method name as a symbol or string (like reduce(:+)) so it knows how to combine the elements.
Since you passed [] instead of a symbol, Ruby throws the error:
[] is not a symbol nor a string (TypeError)
## Summary of Fixes
To force Ruby to give the block to reduce, you must change the binding strength using one of two ways:

# Fix 1: Use parentheses to isolate the 'p' method
p(array.reduce([]) do |acc, ele|
  acc + ele
end)
# Fix 2: Use curly braces so the block binds tightly to 'reduce'
p array.reduce([]) { |acc, ele| acc + ele }

Would you like to see another common example where do...end vs curly braces causes bugs in Ruby, or should we look at how to debug precedence issues using Ruby's built-in parser tools?


=end