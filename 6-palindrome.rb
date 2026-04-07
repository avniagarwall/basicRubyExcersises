if ARGV.length == 0 || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

class String
  def palindrome?
    self == self.reverse
  end
end

str = ARGV[0]

if str.palindrome?
  puts "Input string is a palindrome"
else
  puts "Input string is not a palindrome"
end