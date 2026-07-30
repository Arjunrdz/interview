In Ruby, code written directly inside a class body is executed when the class is being defined, not when an instance is created. At that point, self is the class object, not an instance.

For example:

class MyClass
  puts self
end


Output:

MyClass


Now consider your question.

Case 1: Calling an instance method from the class body
class MyClass
  def greet
    puts "Hello"
  end

  case true
  when true
    greet
  end
end


This will raise an error:

NoMethodError: undefined method `greet' for MyClass:Class


Why?

greet is an instance method.
Inside the class body, self is MyClass (the class), not an instance of MyClass.
The class object doesn't have an instance method named greet.
Case 2: Make it a class method
class MyClass
  def self.greet
    puts "Hello"
  end

  case true
  when true
    greet
  end
end


This works because greet is now a class method, and self inside the class body is the class.

Case 3: Create an instance explicitly

If you really want to call an instance method, you need an instance:

class MyClass
  def greet
    puts "Hello"
  end

  case true
  when true
    new.greet
  end
end


This also works because new creates an instance, and greet is invoked on that instance.

Summary
Where the call happens	Method type	Works?
Directly in class body	Instance method	❌ No
Directly in class body	Class method	✅ Yes
Directly in class body using new.method	Instance method	✅ Yes

So if your case ... when is directly inside the class definition (not inside any method), then calling a method by name will only work if it's a class method (or if you explicitly create an instance and call the instance method on it).
