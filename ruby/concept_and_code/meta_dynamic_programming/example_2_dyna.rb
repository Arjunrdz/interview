=begin
## What Is Dynamic Behavior in Ruby?
## Dynamic behavior means that many decisions are made at runtime rather than being fixed completely at compile time.
  Examples of Ruby’s dynamic behavior:
  - method calls are resolved at runtime,
  - classes can be reopened,
  - modules can be included later,
  - methods can be added to individual objects,
  - constants can be created dynamically,
  - missing methods can be intercepted,
  - objects can be duplicated, cloned, frozen, extended,
  - code can be evaluated from strings,
  - classes can be created anonymously,
  - method visibility can change at runtime.
=end

# Adding a method to one object only

dog = Object.new
def dog.bark
  "Woofs!"
end
p dog.bark

# Here, only this particular object receives the method bark. Other instances of Object do not.