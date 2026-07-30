start with: ruby/concept_and_code/lld/creational/singleton/singleton.rb

In Ruby, the symbol => has two entirely different meanings depending on where and how it is used in the code.
## 1. The Hash Rocket (Key-Value Separator)
Historically, => is called a "hash rocket." It is used to map keys to values when creating a Hash. [1, 2] 

* Example: user = { "name" => "Alice", "age" => 30 }
* Note: In modern Ruby, it is mostly used when keys are strings, numbers, or constants. If the keys are symbols, the colon syntax { name: "Alice" } is preferred.

## 2. Exception Assignment (In rescue blocks)
When handling errors, => assigns the raised exception object to a variable so you can inspect it. [3] 

* Example:

begin
  # Code that might failrescue StandardError => e
  puts e.message # 'e' holds the error detailsend

[4] 

------------------------------
## Analyzing Your Specific Example
Your example looks like a line from a pattern matching structure or an error rescue simulation (often seen in documentation, test outputs, or interactive IRB sessions).

Logger.get_instance => NoMemoryError

In modern Ruby (version 2.7 and later), this represents Right-Hand Side (RHS) Pattern Matching, specifically a Value Pattern match.

* What it does: It evaluates the left side (Logger.get_instance). It then checks if that result matches the pattern on the right side (NoMemoryError).
* The Catch: If the left side does not return an instance of NoMemoryError, Ruby will automatically raise a NoMatchingPatternError.

If this line was copied from a documentation example, it is likely shorthand showing that calling Logger.get_instance will result in, or return, a NoMemoryError.
To help clarify exactly how this behaves in your code, could you tell me:

* Is this line inside a begin/rescue block, a case/in statement, or standing alone?
* Are you trying to catch an error or test a specific behavior?

I can provide the exact code structure you need based on your goal.

[1] [https://www.scaler.com](https://www.scaler.com/topics/ruby/hashes-in-ruby/)
[2] [https://medium.com](https://medium.com/@inesgs/intro-to-hashes-1a030239f9b9)
[3] [https://www.scaler.com](https://www.scaler.com/topics/ruby-exceptions/)
[4] [https://stackoverflow.com](https://stackoverflow.com/questions/14587700/how-to-make-script-continues-to-run-after-raise-statement-in-ruby)
