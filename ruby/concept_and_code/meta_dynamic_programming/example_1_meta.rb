# Simple runtime method definition

class Person
  [:name, :age, :mail].map do |attr|
    define_method(attr) do 
      instance_variable_get("@#{attr}")
    end

    define_method("#{attr}=") do |value|
      instance_variable_set("@#{attr}", value.strip)
    end
  end
end 

p = Person.new
p.name = "Alice"
puts p.name

=begin why not write "#{attr}" for getter method?
Both work fine. `define_method(attr)` and `define_method("#{attr}")` are equivalent here because:

- `attr` is already a Symbol (e.g. `:name`)
- `"#{attr}"` converts it to a String `"name"`
- `define_method` accepts both Symbols and Strings as the method name

So `:name` and `"name"` both define the same method. The getter uses `attr` directly (a Symbol) just for brevity — no conversion needed since `instance_variable_get("@#{attr}")` already does the string interpolation for the ivar lookup.

The setter *needs* the string interpolation `"#{attr}="` specifically to append the `=` character, which you can't do with a plain Symbol without converting it first. You could also write it as `:"#{attr}="` to keep it a Symbol, but the string form is more readable.
=end

=begin for setter why use =
In Ruby, using the = sign in a method name tells the language to treat that method as an assignment operator.
## 1. It Enables Natural Syntax
Without the =, you would have to call the setter method like a regular function using parentheses or spaces.

| Method Name | How you must call it |
|---|---|
| def set_name(value) | p.set_name("Alice") |
| def name_setter(value) | p.name_setter "Alice" |
| def name=(value) | p.name = "Alice" |

The = allows you to use standard assignment syntax, making your custom objects behave exactly like built-in Ruby variables.
## 2. Ruby Syntactic Sugar
When Ruby sees the expression p.name = "Alice", it automatically rewrites it behind the scenes to a method call:

p.name=("Alice")

Ruby allows spaces around the = during execution, so p.name = "Alice" and p.name="Alice" do the exact same thing.
## 3. It Clearly Separates Intents
Using the exact same base name with and without the = creates a clear pairing for data flow:

* p.name (Getter): Pulls data out of the object.
* p.name = (Setter): Pushes data into the object.

[1] [https://www.reddit.com](https://www.reddit.com/r/ruby/comments/9454y1/are_getters_and_setters_bad_practice_in_ruby/)

=end