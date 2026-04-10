if ARGV.empty? || ARGV.length < 2
  puts "Please provide an input"
  exit
end

class Array
  def power(x)
    map { |num| num ** x }
  end
end

puts eval(ARGV[0]).power(ARGV[1].to_i).inspect