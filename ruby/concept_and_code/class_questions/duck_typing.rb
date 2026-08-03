# Duck typing in Ruby is the concept of focusing on an object's behavior (the methods it can respond to) rather than its specific class

class ConsoleLogger
  def message(message)
    puts "I am inside #{message}"
  end
end

class FileLogger
  def message(message)
    puts "I am inside #{message}"
  end
end

def process_data(logger, message)
  logger.message(message)
end

process_data(ConsoleLogger.new, "Console Logger")
process_data(FileLogger.new, "File Logger")