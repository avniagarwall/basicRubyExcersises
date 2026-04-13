if ARGV.empty? || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

class PrimeFinder
  def initialize(n)
    @n = Integer(n)
    raise ArgumentError, "Input must be greater than 1" if @n < 2
  end

  def primes
    [].tap do |result|
      2.step(@n) do |num|
        result << num if prime?(num)
      end
    end
  end

  private

  def prime?(num)
    return false if num < 2
    2.step(Math.sqrt(num).to_i) do |i|
      return false if num % i == 0
    end
    true
  end
end

puts PrimeFinder.new(ARGV[0]).primes.inspect