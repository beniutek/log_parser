require 'singleton'

class Logger
  include Singleton

  def self.log(text)
    time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    puts "#{time}: #{text}"
  end
end
