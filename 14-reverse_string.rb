if ARGV.length == 0 || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

str = ARGV[0]

result = str.split.reverse.join(" ")

puts "\"#{result}\""