require_relative 'command'

class Write < Command
  def execute
    Logger.log("write execute")
    context.parsed_log.ordered.each { |line| write_line(line) }
  end

  def write_line(line)
    puts context.compose_line(line)
  end
end
