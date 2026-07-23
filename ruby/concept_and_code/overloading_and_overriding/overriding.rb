=begin
Method overriding occurs when a child class provides its own implementation of a method defined in the parent class.
=end

class Animal
  def sound
    puts "Animal makes a sound"
  end
end

class Dog < Animal
  def sound
    puts "Dog barks"
  end
end

animal = Animal.new
animal.sound

dog = Dog.new
dog.sound

# Method overring with super
class Animal
  def sound
    puts "Animal makes a sound"
  end
end

class Dog < Animal
  def sound
    super
    puts "Dog barks"
  end
end

dog = Dog.new
dog.sound