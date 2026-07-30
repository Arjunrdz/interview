class Logger_Try
  @instance = nil # This creates class instance variable belonging to the object Logger itself not to the instance of it.
  # Since classes are objects in Ruby, they can have instance variables.
  # So @instance belongs to the object Logger, not to instances created by Logger.new.
  
  def get_instance
    if @instance == nil
      @instance = Logger_Try.new
    else
      @instance
    end
  end

  private
  def initialize(); end # Initialize being private does not prevent anyone from calling Logger.new because new is still public. new internally calls initialize
  # Since new is public multiple Logger.new works hence it is not singleton

end

l1 = Logger_Try.new
l1.get_instance

# Correct version: Making new private
class Logger
  @instance = nil

  def self.get_instance
    @instance ||= new
  end

  private_class_method :new
end

# Logger.new =>  NoMethodError
# Logger.get_instance => NoMemoryError (check Q0)

logger1 = Logger.get_instance
logger2 = Logger.get_instance

puts logger1.equal?logger2