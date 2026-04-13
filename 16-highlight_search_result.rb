if ARGV.length < 2 || ARGV[0].strip.empty? || ARGV[1].strip.empty?
  puts "Please provide an input"
  exit
end

class StringSearcher
  def initialize(text, search)
    @text   = text
    @search = search
    @regex  = Regexp.new(Regexp.escape(@search), Regexp::IGNORECASE)
  end

  def highlight
    @text.gsub(@regex) { |match| "(#{match})" }
  end

  def count
    @text.scan(@regex).length
  end

  def to_s
    "#{highlight}\nTotal occurrences found: #{count}"
  end
end

puts StringSearcher.new(ARGV[0], ARGV[1]).to_s