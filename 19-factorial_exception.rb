if ARGV.length == 0 || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

begin
  n = Integer(ARGV[0])

  raise "Negative number entered" if n < 0

  result = (1..n).inject(1) { |fact, num| fact * num }

  puts result

rescue ArgumentError
  puts "Invalid input"
rescue => e
  puts e.message
end