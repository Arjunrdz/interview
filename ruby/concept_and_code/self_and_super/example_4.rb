module D
  def greet
    puts "Hello from D."
  end 
end

module C
  include D
  def greet
    super
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
Hello from D.
Hello from C.
Hello from A.
=end

p A.ancestors # [A, C, D, B, Object, Kernel, BasicObject]

## Becuase ancestor chaining to normally shuru hui: A -> D -> C , pr C pr code dubara D pr gaya. Ruby doesn't create duplicate module entried. So ancestor chaining updates to: A -> C -> D -> B -> Object -> Kernel -> BasicObject . Not the greet calls through the chaining: Class A -> encountered super -> (The rule of priority breaks here D won't be called but C according to chaining. But not exactly any breaking as C already contains D so logically C is more prioritized) -> module C -> encountered super -> Module D -> Print from D -> Print from C -> Print from A

