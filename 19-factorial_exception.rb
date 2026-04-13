if ARGV.empty? || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

class Factorial
  def initialize(n)
    @n = Integer(n)
    raise ArgumentError, "Input must be a non-negative integer" if @n < 0
  end

  def compute
    (1..@n).inject(1) { |fact, num| fact * num }
  end
end

begin
  puts Factorial.new(ARGV[0]).compute
rescue ArgumentError => e
  puts e.message
end