if ARGV.length == 0
  puts "Please provide an input"
  exit
end

str = ARGV[0]
result = str.gsub(/[aeiouAEIOU]/, '*')

puts result