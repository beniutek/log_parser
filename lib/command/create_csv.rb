require_relative 'command'

class CreateCsv < Command
  def execute
    Logger.log("create csv executing")
    File.open(context.csv_filename, 'w') do |file|
      file.write(context.compose_header)

      context.parsed_log.result.each do |key, val|
        line = "#{key},#{val[:unique_count]},#{val[:all_count]}\n"
        file.write(context.compose_line(line))
      end
    end
  end
end
