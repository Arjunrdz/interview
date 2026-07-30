module D
  def greet
    puts "Hello from D."
  end 
end

module C
  def greet
    puts "Hello from C."
  end
end

class B
  def greet
    puts "Hello from B."
  end
end

class A < B
  include C
  include D
  def greet
    super
    puts "Hello from A."
  end
end

a = A.new
a.greet
# Hello from D.
# Hello from A.
p A.ancestors
# [A, D, C, B, Object, Kernel, BasicObject]
# Note: As you can see from above output => We can't look at ancestors chain and determine which method would be called

# Class only inheritance chain: ignoring modules
current_class = A
while current_class
  puts current_class
  current_class = current_class.superclass
end

# Visualica where method live
p A.instance_method(:greet).owner
p A.instance_method(:puts).owner

#-------------------------------------------------------------------------
module D
  def greet
    super
    puts "Hello from D."
  end 
end

module C
  def greet
    puts "Hello from C."
  end
end

class B
  def greet
    puts "Hello from B."
  end
end

class A < B
  include C
  include D
  def greet
    super
    puts "Hello from A."
  end
end

a = A.new
a.greet
=begin
Now the output becomes:
Hello from C.
Hello from D.
Hello from A.

Even though there is no include, exclude, prepend, < in module D, super still ran and went to next method in lookup chain (C) because of this important definition of super: "Continue lookup after the class/module where the current method was found."
=end