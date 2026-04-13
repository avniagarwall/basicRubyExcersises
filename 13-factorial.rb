if ARGV.empty? || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

class Factorial
  def initialize(n)
    @n = Integer(n)
  end

  def compute
    (1..@n).inject(1) { |fact, num| fact * num }
  end
end

puts Factorial.new(ARGV[0]).compute