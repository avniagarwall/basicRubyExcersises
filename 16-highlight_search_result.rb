if ARGV.length < 2 || ARGV[0].strip.empty? || ARGV[1].strip.empty?
  puts "Please provide an input"
  exit
end

text = ARGV[0]
search = ARGV[1]

regex = Regexp.new(Regexp.escape(search), Regexp::IGNORECASE)

count = 0

result = text.gsub(regex) do |match|
  count += 1
  "(#{match})"
end

puts result
puts "Total occurrences found: #{count}"