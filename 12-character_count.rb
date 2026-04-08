if ARGV.length == 0 || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

str = ARGV[0]

lower = 0
upper = 0
digit = 0
special = 0

str.each_char do |ch|
  if ('a'..'z').include?(ch)
    lower += 1
  elsif ('A'..'Z').include?(ch)
    upper += 1
  elsif ('0'..'9').include?(ch)
    digit += 1
  else
    special += 1
  end
end

puts "Lowercase characters = #{lower}"
puts "Uppercase characters = #{upper}"
puts "Numeric characters = #{digit}"
puts "Special characters = #{special}"