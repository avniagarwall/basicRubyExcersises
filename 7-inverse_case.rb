if ARGV.length == 0 || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

class String
  def to_s
    result = ""

    self.each_char do |ch|
      if ch >= 'a' && ch <= 'z'
        result += ch.upcase
      elsif ch >= 'A' && ch <= 'Z'
        result += ch.downcase
      else
        result += ch
      end
    end

    result
  end
end

str = ARGV[0]
puts str.to_s