=begin
The ancestors method is your single most important debugging tool when reasoning about method lookup. It returns the linearized lookup chain. Ruby uses a single-pass linearization: it does not search a graph; it searches a list. The list is constructed at the moment a class or module is defined or modified, and it is reconstructed whenever include, prepend, or extend is invoked.
=end

module Walkable
  def walk; "walking"; end
end 

module Talkable
  def speak; "talking"; end
end

class Person
  include Walkable
  include Talkable
end

p Person.ancestors # => [Person, Talkable, Walkable, Object, Kernel, BasicObject]
# Notice the order: Talkable appears before Walkable even though Walkable was included first. This is because include inserts modules immediately after the class in the ancestors chain, and successive includes stack on top of each other. The most recently included module ends up closest to the class.

=begin
In Ruby, Module Linearization (or C3 Superclass Linearization) resolves inheritance and mixin hierarchies into a strict, one-dimensional lookup chain. It is used by the interpreter to determine the exact order in which Ruby searches for methods when super is called.

Because Ruby is a dynamically typed, single-inheritance language, it avoids the "diamond of death" (ambiguity) in multiple inheritance by relying on this single, strictly defined chain.
=end # Example of modular linearization below (It's just a technical name of what we have been doing so far)

module M1
end

module M2
end

class ParentClass
end

class MyClass < ParentClass
  prepend M1
  include M2
end

# Check the linearization path
p MyClass.ancestors
# => [M1, MyClass, M2, ParentClass, Object, Kernel, BasicObject]
