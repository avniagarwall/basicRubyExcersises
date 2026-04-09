if ARGV.length < 2 || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

arr = eval(ARGV[0])   
power_value = ARGV[1].to_i

class Array
  def power(x)
    self.map { |num| num ** x }
  end
end

result = arr.power(power_value)
puts result.inspect