if ARGV.empty?
  warn "Please provide an input"
  exit 1
end

ALPHA = /[A-Za-z]/i

count = Hash.new(0)
ARGV[0].each_char { 
  |ch| count[ch] += 1 if ALPHA.match?(ch) 
}

puts count