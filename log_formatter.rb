#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require_relative 'lib/argument_parser.rb'
require_relative 'lib/parser.rb'
require_relative 'lib/writer.rb'
require_relative 'lib/logger/logger.rb'
require_relative 'lib/command/create_csv.rb'
require_relative 'lib/command/create_file.rb'
require_relative 'lib/command/write.rb'
require_relative 'lib/decorators/decorated_line_numbers_entry.rb'
require_relative 'lib/decorators/decorated_timestamp_entry.rb'

Logger.log("starting the script")
arg_parser = ArgumentParser.new(ARGV)
Logger.log("args parsed")
parser = Parser.new(arg_parser.log_file) do |x|
  x.result
   .sort_by { |key, val| [-val[:unique_count], key] }
   .map { |key, val| "#{key} #{val[:unique_count]} unique views" }
end

parser.parse!
Logger.log("parser done")
writer = Writer.new(parser, arg_parser)

if arg_parser.timestamp?
  Logger.log("extending writer with timestamps")
  writer.extend(DecoratedTimestampEntry)
end

if arg_parser.line_numbers?
  Logger.log("extending writer with numbered lines")
  writer.extend(DecoratedLineNumbersEntry)
end

if arg_parser.print_to_csv?
  writer.execute(CreateCsv)
elsif arg_parser.print_to_file?
  writer.execute(CreateFile)
else
  writer.execute(Write)
end

Logger.log("script finished")
