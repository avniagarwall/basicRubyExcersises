if ARGV.empty? || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit 1
end

class String
  def palindrome?
    cleaned = downcase.gsub(/[^a-z0-9]/, '')
    cleaned == cleaned.reverse
  end
end

str = ARGV[0]

if str.palindrome?
  puts "Input string is a palindrome"
else
  puts "Input string is not a palindrome"
end