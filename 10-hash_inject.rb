if ARGV.length == 0 || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

arr = eval(ARGV[0])

grouped = {}

arr.each do |elem|
  str = elem.to_s
  len = str.length

  grouped[len] ||= []
  grouped[len] << str
end

result = grouped.sort.inject({}) do |acc, (len, values)|
  key = len.even? ? "even" : "odd"

  acc[key] ||= []
  acc[key] << values

  acc
end

puts result