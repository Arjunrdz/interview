You cannot call 1.superclass because superclass is a method that only belongs to classes, not to individual data instances. [1, 2, 3] 
Here is exactly why Ruby splits this up:
## 1 is an instance, not a blueprint

* class is a method available to every object in Ruby. It answers the question: "What blueprint created me?" [2] Since 1 is an object, it can answer that question (Integer).
* superclass is a method that only exists inside the Class engine. It answers the question: "What parent blueprint did this blueprint inherit from?" [4, 5, 6] 

Because 1 is just a raw number instance (and not a class blueprint itself), it does not have the superclass method. [7] 
## How to see it in IRb
If you try to call it directly on 1, Ruby will throw a NoMethodError:
```
irb(main):001> 1.superclass
NoMethodError (undefined method `superclass' for 1:Integer)
```

To use superclass, you must first climb up to the class level using .class, and then ask for the superclass: [8] 
```
irb(main):002> 1.class.superclass
=> Numeric
```

If you want to see exactly where these methods live, let me know if you want to check which methods belong to Object versus Class using Ruby's instance_methods command! [9] 
