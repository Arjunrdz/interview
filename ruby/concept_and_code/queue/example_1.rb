require 'thread'

# Queue is intentionally minimal because it's designed for synchronization rather than inspection.
queue = Queue.new

# p queue
p queue.empty?
queue.push("apple")
puts queue.size 
queue << "banana"
queue.enq("mango")
puts queue.size 
puts queue # #<Thread::Queue:0x000076a60c515a08>
p queue # <Thread::Queue:0x000075f160ed4ca8>
p queue.inspect # "#<Thread::Queue:0x000075f160ed4ca8>"

#--------------------------------------------Start: 1-----------------------------------------------------------------------------------------
=begin
The reason puts queue prints #<Thread::Queue:0x0000788167fc51f0> instead of the items inside it is because puts calls the to_s (string representation) method of the object. Ruby's Queue class does not override to_s to print its contents; it only shows its class name and memory address.
=end
#--------------------------------------------End: 1-----------------------------------------------------------------------------------------


#--------------------------------------------Start: 2-----------------------------------------------------------------------------------------
# Ways to get elements inside the queue
# First: By putting these variables inside the array
# elements = []

# elements << queue.pop until queue.empty?
# p elements

# puts queue.empty?
# Second: accessing internal variable
p queue.instance_variable_get(:@que)

=begin
The reason code printed nil is because CRuby (the standard Ruby implementation) rewritten Thread::Queue entirely in C. [1] 
Because it is implemented in C, the @que Ruby instance variable no longer exists inside the class. When we call instance_variable_get(:@que) on an instance variable that isn't defined, Ruby silently returns nil. [1, 2] 
## How to actually see the elements
Since internal C variables cannot be peeked at using instance_variable_get, we have to use alternative methods depending on our exact goal. [2] 
## Option 1: Marshal Dumping (Great for debugging without modifying the queue)
Ruby's Marshal module can serialize the queue object, which forces it to reveal its internal array state. We can extract it using a regex or simple string manipulation.

# Serialize the queue and match the inner array contents
dump = Marshal.dump(queue)
p dump.scan(/["']\w+["']/) # Output: ["apple", "banana", "mango"]

## Option 2: The Non-Destructive Safe Loop
If you need to view the contents safely during execution, empty the queue into a temporary array and push them right back in.

elements = []
elements << queue.pop until queue.empty?

p elements # Output: ["apple", "banana", "mango"]
# Restore the queue state
elements.each { |item| queue << item }

## Option 3: Track data with a Wrapper Class
If you find yourself constantly needing to look inside the queue during development, wrap it in a custom class that keeps a separate thread-safe log of active entries.

class DebuggableQueue < Queue
  attr_reader :history

  def initialize
    super
    @history = []
  end

  def push(obj)
    @history << obj
    super
  end
  alias << push
  alias enq push

  def pop(non_block = false)
    item = super
    @history.delete_at(@history.index(item) || -1) if item
    item
  end
  alias deq pop
  alias shift popend


[1] [https://ruby-doc.org](https://ruby-doc.org/stdlib-trunk/libdoc/thread/rdoc/Queue.html)
[2] [https://ruby-doc.org](https://ruby-doc.org/core-3.1.1/Object.html)

=end
#--------------------------------------------End: 2-----------------------------------------------------------------------------------------


#--------------------------------------------Start: 3 (removing elements)-----------------------------------------------------------------------------------------
# queue.pop
# queue.deq
# puts queue.size
#First inserted → First removed.
#--------------------------------------------End: 3-----------------------------------------------------------------------------------------

#--------------------------------------------Start: 4 (non blocking pop)-----------------------------------------------------------------------------------------
q = Queue.new
q.pop 
=begin
Queue#pop is blocking by default. Since q is empty and no other thread will ever push an item into it, the main thread goes to sleep forever. Ruby detects that every thread is sleeping and raises a fatal deadlock error:
=end
#--------------------------------------------End: 4 (non blocking pop)-----------------------------------------------------------------------------------------

