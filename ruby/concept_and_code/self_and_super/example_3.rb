
class B
  def greet
    puts "Hello from B."
  end
end

class A < B
  # include C
  # include D
  def greet
    super
    # puts "Hello from A."
  end
end

p A.ancestors # [A, B, Object, Kernel, BasicObject]

=begin Why kernel is in output when we never used any method associated with it?

Kernel appears in A.ancestors because every normal Ruby object gets Kernel mixed into Object by default.

Your hierarchy is:

class B
end

class A < B
end


When you ask:

p A.ancestors


Ruby walks the inheritance chain and also includes any modules that have been mixed in.

The result is:

[A, B, Object, Kernel, BasicObject]


Here's why each one is there:

BasicObject
    ↑
 Object
   ↑
   B
   ↑
   A


But Object itself includes the Kernel module:

Object.ancestors
# => [Object, Kernel, BasicObject]


So the actual lookup chain becomes:

A
↓
B
↓
Object
↓
Kernel   # included in Object
↓
BasicObject

Why Kernel?

Kernel provides methods that are available almost everywhere in Ruby, such as:

puts
p
print
gets
loop
sleep
raise
rand


For example,

puts "Hello"


works inside any object because puts is not defined on Object; it's defined in Kernel.

You can verify this:

Kernel.instance_methods(false).grep(/puts/)
# => [:puts]


or

Object.instance_methods.include?(:puts)
# => true


The second returns true because Object includes Kernel.

You can inspect it
Object.ancestors
# => [Object, Kernel, BasicObject]

Kernel.ancestors
# => [Kernel]

BasicObject.ancestors
# => [BasicObject]

Method lookup in your example

When you call:

A.new.greet


Ruby searches in this order:

A
B
Object
Kernel
BasicObject

Since greet is found in A, it executes A#greet, and when super is called, Ruby continues the search after A, finding B#greet.

So Kernel isn't related to your classes directly—it appears because Object includes it, making its methods available to almost every object in Ruby. This is one of the reasons methods like puts work without you having to include any module yourself.

=end