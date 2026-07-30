class Base
  def name
    "Base"
  end
end

module AroundAdvice
  def name
    "AroundAdvice before -> #{super}"
  end
end

class Child < Base
  prepend AroundAdvice
  def name
    super
    "child"
  end
end

p Child.new.name # "AroundAdvice before -> child"
p Child.ancestors # [AroundAdvice, Child, Base, Object, Kernel, BasicObject]

=begin for super to work we must have include, prepend, < , or extend in method?? Not really. Check important.txt
=end

=begin Why output is not "Base"?
- Nothing too complex we just ignored it as last value is the return value. To see it get printed out check below example.
=end

class Base
  def name
    puts "Base"
  end
end

module AroundAdvice
  def name
    "AroundAdvice before -> #{super}"
  end
end

class Child < Base
  prepend AroundAdvice
  def name
    super
    puts "child"
  end
end

p Child.new.name
p Child.ancestors