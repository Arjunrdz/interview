# def test
#   def hello
#     yield
#     puts "In hello"
#   end
#   hello
#   puts "In test outside hello"
# end

# puts test { "hello" }

# Above code won't work becuase inner method hello has no way of knowing whether a block was even passed or not. It will result in LocalJumpError

def test(&block)
  def hello(&block)
    puts "Inside hello before yield is called"
    yield
    puts "Inside hello after yield is called"
  end
  puts "Inside test before hello is called"
  hello(&block)
  puts "Inside test after hello is called"
end

# test { puts "Yield ran where?" }
test { break "How far we went?" } # same behaviour with return
