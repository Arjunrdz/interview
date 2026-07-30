# map transforms each element of a collection and returns a new array.

arr = [1,2,3]
p arr.map {|n| n * 2} # New array returned [2, 4, 6]
p arr # Doesn't modify

# map is also aliased as collect.
p [1,2,3].collect {|n| n * 2}
p arr

# With method to block conversion: collection.map(&:method_name)
names = ["alice", "bob", "charlie"]
# p names.map {|name| name.upcase} or
p names.map(&:upcase)
=begin
Because .map demands a block, you need a translator to turn your symbol (:upcase) into an executable chunk of code.When you place the & character in front of an object inside a method call, Ruby automatically triggers a built-in hooks system:

- It calls the to_proc method on that object.
- The Symbol#to_proc method generates an anonymous procedure (a block wrapper).
- The & operator then passes that block directly into .map.
=end