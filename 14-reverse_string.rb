if ARGV.empty? || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

class SentenceReverser
  def initialize(str)
    @str = str
  end

  def reverse_words
    @str.split.reverse.join(" ")
  end
end

puts SentenceReverser.new(ARGV[0]).reverse_words