require 'date'

start = DateTime.now

e = start.to_time + 1

puts "#{(e.to_time - start.to_time) / 60}"
