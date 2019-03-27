#
# allowed options:
# -f filename -> save output to file
# -csv filename -> save output as csv file
#
class ArgumentParser
  attr_reader :opts, :log_file

  class NoArgumentsError < StandardError
  end

  class ArgumentNotFoundError < StandardError
  end

  def initialize(args = [])
    raise  NoArgumentsError if args.nil? || args.size == 0

    *@opts, @log_file = args
  end

  def no_options?
    opts.empty?
  end

  def print_to_csv?
    opts.include?('-csv')
  end

  def csv_filename
    raise ArgumentNotFoundError unless opts.index('-csv')
    opts[opts.index('-csv')+1]
  end

  def print_to_file?
    opts.include?('-f')
  end

  def file_filename
    raise ArgumentNotFoundError unless opts.index('-f')
    opts[opts.index('-f')+1]
  end
end