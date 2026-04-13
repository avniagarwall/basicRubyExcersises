if ARGV.empty? || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

class StringAnalyzer
  LOWERCASE = /[a-z]/
  UPPERCASE = /[A-Z]/
  DIGIT     = /[0-9]/

  def initialize(str)
    @str = str
  end

  def analyze
    Hash.new(0).tap do |count|
      @str.each_char do |ch|
        case ch
        when LOWERCASE then count[:lower]   += 1
        when UPPERCASE then count[:upper]   += 1
        when DIGIT     then count[:digit]   += 1
        else                count[:special] += 1
        end
      end
    end
  end

  def to_s
    result = analyze
    "Lowercase characters = #{result[:lower]}\n"  \
    "Uppercase characters = #{result[:upper]}\n"  \
    "Numeric characters   = #{result[:digit]}\n"  \
    "Special characters   = #{result[:special]}"
  end
end

puts StringAnalyzer.new(ARGV[0]).to_s