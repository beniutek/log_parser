# Log Formatter

Log formatter is a simple script to format logs and count unique views

## Usage

run ruby log_formatter.rb FILEWITHLOGS

## Options

`-csv foo.csv`
will save the output to a comma delimited file foo.csv

`-f file.txt`
will save the output to a text file

`-o timestamp`
will produce timestamps in the csv output

`-o line_numbers`
will produce additional line numbers

## Tests

`gem install bundler`

`bundle install`

and then run

`rspec`
