#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require_relative 'lib/parser.rb'
require_relative 'lib/argument_parser.rb'
require_relative 'lib/writer.rb'

arg_parser = ArgumentParser.new(ARGV)
parsed = Parser.new(arg_parser.log_file).parse!
writer = Writer.new(parsed, arg_parser)

writer.write

