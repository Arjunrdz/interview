To find out which class a method belongs to, use the owner method on the Method or UnboundMethod object. [1] 
Here are the direct ways to check the owner of m1 using your code structure:
## 🔍 Solution 1: Check via the Class (Unbound)
You do not need to create an instance of A to check where the method is defined. [2] 

```
A.instance_method(:m1).owner
# => A
```

## 🔍 Solution 2: Check via an Instance
If you already have an object instance, look up the method on that object and call owner. [3] 

```
obj = A.new
obj.method(:m1).owner# => A
```

## 💡 Why this is useful
The owner method is highly useful when debugging inheritance or modules. If a class inherits a method from a parent class or includes a module, owner will return the exact module or parent class where the source code of that method actually lives. [4, 5] 

```
module MyModule
  def m1; endend
class A
  include MyModuleend

A.instance_method(:m1).owner# => MyModule
```


[1] [https://www.geeksforgeeks.org](https://www.geeksforgeeks.org/ruby/how-to-find-where-a-method-is-defined-at-runtime-in-ruby/)
[2] [https://www.codingem.com](https://www.codingem.com/python-staticmethod-vs-classmethod/)
[3] [https://www.tech-artists.org](https://www.tech-artists.org/t/python-get-fully-qualified-name-of-static-function-object/5526)
[4] [https://www.geeksforgeeks.org](https://www.geeksforgeeks.org/ruby/how-to-find-where-a-method-is-defined-at-runtime-in-ruby/)
[5] [https://www.scaler.com](https://www.scaler.com/topics/class-method-in-python/)
