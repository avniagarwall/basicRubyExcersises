if ARGV.length == 0
  puts "Please provide an input"
  exit
end

str = ARGV[0]
count = {}

str.each_char do |ch|
  if ch =~ /[A-Za-z]/   
    count[ch] = count[ch].to_i + 1
  end
end

puts count