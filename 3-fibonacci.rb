if ARGV.empty?
  puts "Please provide an input"
  exit 1
end

class Fibonacci
  def initialize(limit)
    @limit = limit
  end

  def each
    a, b = 0, 1
    while b <= @limit
      yield b
      a, b = b, a + b
    end
  end
end

puts Fibonacci.new(ARGV[0].to_i).each{ |num| print "#{num} " }