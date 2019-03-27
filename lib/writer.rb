class Writer
  attr_reader :parsed_log, :arg_parser

  def initialize(parsed_log, arg_parser)
    @parsed_log = parsed_log
    @arg_parser = arg_parser
  end

  def write
    basic_write if arg_parser.no_options?
    create_csv if arg_parser.print_to_csv?
    create_file if arg_parser.print_to_file?
  end

  private

  def basic_write
    parsed_log.ordered.each { |line| puts line }
  end

  def create_csv
    File.open(arg_parser.csv_filename, 'w') do |file|
      file.write("webpage,unique_views,all_views\n")
      parsed_log.result.each do |key, val|
        file.write("#{key},#{val[:unique_count]},#{val[:all_count]}\n")
      end
    end
  end

  def create_file
    File.open(arg_parser.file_filename, 'w') do |file|
      parsed_log.ordered.each { |line| file.write("#{line}\n") }
    end
  end
end