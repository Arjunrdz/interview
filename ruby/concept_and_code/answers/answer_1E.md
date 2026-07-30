arjunsharma@arjun-sharma-3420-24:~$ irb

⢀⡴⠊⢉⡟⢿  IRB v1.18.0 - Ruby 3.3.3
⣎⣀⣴⡋⡟⣻  "ls [object]" to see methods and properties
⣟⣼⣱⣽⣟⣾  ~

irb(main):001* def
irb(main):002*   yield
irb(main):003*   puts "Hello"
irb(main):004> end
=> :yield
irb(main):005> yield
(irb): (irb):5: Invalid yield (SyntaxError)
irb(main):006> send(:yield)
Hello
=> nil
irb(main):007* def
irb(main):008*   yield; puts "Hello"
irb(main):009> end
=> :yield
irb(main):010> send(:yield)
Hello
=> nil
irb(main):011> 
