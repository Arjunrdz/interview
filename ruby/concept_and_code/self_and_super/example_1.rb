class Animal
  def walk
    puts "Animal Walks"
  end
end

class Dog < Animal
  # super: super called outside of method (NoMethodError)
  def walk
    super
    puts "Dog Walks"
  end
end

d = Dog.new
d.walk
p d.class
# p d.superclass: undefined method `superclass' for an instance of Dog (NoMethodError)
p Dog.methods # Returs class method not instance method
p Dog.instance_methods()
p Dog.instance_methods(false) # False means skip inheritance chain loopup
p d.methods.include?(:walk) 
p Dog.ancestors