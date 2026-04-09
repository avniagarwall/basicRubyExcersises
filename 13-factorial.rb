if ARGV.length == 0 || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

n = ARGV[0].to_i

result = (1..n).inject(1) { |fact, num| fact * num }

puts result