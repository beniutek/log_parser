class Writer
  attr_reader :parsed_log, :args

  def initialize(parsed_log, args)
    @parsed_log = parsed_log
    @args = args
  end

  def execute(command_class)
    command_class.new(self).execute
  end

  def csv_filename
    args.csv_filename
  end

  def file_filename
    args.file_filename
  end

  def compose_header
    "webpage,unique_views,all_views\n"
  end

  def compose_line(line)
    Logger.log("writer is composing the line: #{line}")
    line
  end
end
