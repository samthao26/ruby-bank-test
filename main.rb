#!/usr/bin/env ruby

require './lib/TechComExtractor.rb'
require './lib/CsvWriter.rb'

threads = []

threads << Thread.new {
  t = TechComExtractor.get
  csv = CSVWriter.new("techcom.csv")

  csv.append_arr(t)
  csv.close
}

threads.each(&:join)
