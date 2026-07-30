class Example
  def method_missing(name, *args)
    if name == :special
      "Special Method"
    else
      super
    end
  end
end

p Example::new::special # Special Method
p Example::new::special1 # NoMethodError
# If we remove super then
p Example::new::special1 # nil
p Example::new::special(1,2,3) # NoMethodError and not ArgumentError because *args passes it to else block in super and prevent ArgumentError