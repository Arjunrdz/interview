## Query 1:
rb(main):080* class Person
irb(main):081*   def greet
irb(main):082*     "Hello #{name}"
irb(main):083*   end
irb(main):084* 
irb(main):085*   def name
irb(main):086*     "Alice"
irb(main):087*   end
irb(main):088> end
irb(main):089> 
irb(main):090> p = Person.new
=> #<Person:0x00007f8d99b84d58>
irb(main):091> p.greet
=> "Hello Alice"
irb(main):092> Person.method(:greet)
(irb):92:in `method': undefined method `greet' for class `#<Class:Person>' (NameError)

Person.method(:greet)
      ^^^^^^^
	from (irb):92:in `<main>'
	from <internal:kernel>:187:in `loop'
	from /home/arjunsharma/.rbenv/versions/3.3.3/lib/ruby/gems/3.3.0/gems/irb-1.18.0/exe/irb:9:in `<top (required)>'
	from /home/arjunsharma/.rbenv/versions/3.3.3/bin/irb:25:in `load'
	from /home/arjunsharma/.rbenv/versions/3.3.3/bin/irb:25:in `<main>'
irb(main):093> 


## Resolution:

The error happens because `greet` is **not a class method**—it's an **instance method**.

In your code:

```ruby
class Person
  def greet
    "Hello #{name}"
  end

  def name
    "Alice"
  end
end
```

Both `greet` and `name` are instance methods, so they belong to instances of `Person`:

```ruby
p = Person.new
p.greet
# => "Hello Alice"
```

When you do:

```ruby
Person.method(:greet)
```

Ruby looks for a method named `greet` **on the `Person` class object itself** (i.e. a class method), not among its instance methods. Since no such class method exists, you get:

```
undefined method `greet' for class `#<Class:Person>'
```

### How to inspect the instance method

If you want the `Method` object bound to an instance:

```ruby
p.method(:greet)
# => #<Method: Person#greet() ...>
```

If you want the unbound method from the class:

```ruby
Person.instance_method(:greet)
# => #<UnboundMethod: Person#greet() ...>
```

You can later bind it to an instance:

```ruby
um = Person.instance_method(:greet)
m = um.bind(p)
m.call
# => "Hello Alice"
```

### If `greet` were a class method

You would define it like this:

```ruby
class Person
  def self.greet
    "Hello"
  end
end
```

or

```ruby
class Person
  class << self
    def greet
      "Hello"
    end
  end
end
```

Then:

```ruby
Person.method(:greet)
# => #<Method: Person.greet() ...>
```

### Summary

* `p.method(:greet)` → returns a `Method` object for an **instance method**.
* `Person.instance_method(:greet)` → returns an **UnboundMethod**.
* `Person.method(:greet)` → looks for a **class method**, so it raises `NameError` unless `greet` was defined with `self.greet` (or equivalent).
