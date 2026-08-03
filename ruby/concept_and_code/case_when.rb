begin
  a = 1
  b = 0
  puts a / b
rescue ZeroDivisionError
  puts "Zero not allowed"
  redo
end
