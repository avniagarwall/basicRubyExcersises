if ARGV.empty? || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

class String
  def to_s
    each_char.map do |ch|
      if ch =~ /[a-z]/
        ch.upcase
      elsif ch =~ /[A-Z]/
        ch.downcase
      else
        ch
      end
    end.join
  end
end

puts ARGV[0].to_s