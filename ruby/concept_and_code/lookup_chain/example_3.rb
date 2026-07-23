=begin
In Ruby, extend doesn't show up in a class's ancestors chain because extend adds methods to an object’s singleton class (sometimes called the eigenclass or metaclass) rather than the main class's inheritance chain
=end

module M1; end
module M2; end

class ParentClass; end

class MyClass < ParentClass; prepend M1; extend M2; end
=begin => When you run extend MyModule inside a class, Ruby essentially does this behind the scenes:
class MyClass
  # extend M2 is equivalent to:
  class << self
    include M2
  end
end
=end

p MyClass.ancestors # => [M1, MyClass, ParentClass, Object, Kernel, BasicObject] => M2 is not visible

p MyClass.singleton_class.ancestors # => [#<Class:MyClass>, M2, #<Class:ParentClass>, #<Class:Object>, #<Class:BasicObject>, Class, Module, Object, Kernel, BasicObject] => M2 is visible now

=begin : Why different outputs?

=end

3.times {
  puts "a"
  puts "b"
}