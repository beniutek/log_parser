require_relative 'command'

class CreateFile < Command
  def execute
    Logger.log("create file executing")
    File.open(context.file_filename, 'w') do |file|
      context.parsed_log.ordered.each { |line| file.write("#{line}\n") }
    end
  end
end
