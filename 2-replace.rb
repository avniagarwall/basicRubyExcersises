if ARGV.empty?
  puts "Please provide an input"
  exit 1
end

class VowelMasker
  VOWELS = /[aeiou]/i

  def initialize(str)
    @str = str.dup
  end

  def mask
    @str.gsub!(VOWELS, "*")
    @str
  end
end

puts VowelMasker.new(ARGV[0]).mask