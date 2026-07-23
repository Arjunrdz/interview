# Let us begin with the most basic case: a class with no ancestors except Object.
class Greeter
  def hello
    "Hello from greeter. Called from class #{self.class} through method #{__method__}"
  end
end
g = Greeter.new
p g.hello
# p g.ancestors => undefined method `ancestors' for an instance of Greeter (NoMethodError)
p Greeter.ancestors # => [Greeter, Object, Kernel, BasicObject]
p g.class.ancestors # => [Greeter, Object, Kernel, BasicObject] # Can use if it triggers your PTSD on why ancestor is not called from instance itself. 

=begin : How the lookup works when g.hello is evaluated

1. Look in the singleton class of g (it's empty here).
2. Look in Greeter itself.
3. Look in Object.
4. Look in Kernel.
5. Look in BasicObject.

=end

=begin : Can we call ancestors method directly on a standard object instance in Ruby.

You cannot !!
The #ancestors method is an instance method of the Module class. Since all classes inherit from Module, only class and module objects can use it.

=end # Or ----

# If you add specialized behavior to a single specific object (singleton/eigenclass methods), that instance technically gets its own hidden class layer. You can view this custom ancestry layer directly.

def g.vip_greeter?
  true
end

p g.singleton_class.ancestors