if ARGV.length < 2
  puts "Please provide an input"
  exit
end

class Interest
  RATE = 0.10

  attr_reader :p, :t

  def initialize(p, t)
    @p = Float(p)
    @t = Float(t)
  end

  def simple_interest
    @p * (1 + RATE * @t)
  end

  def compound_interest
    @p * (1 + RATE) ** @t
  end

  def difference
    format("%.2f", compound_interest - simple_interest)
  end

  def to_s
    "Principal        : #{@p}\n"           \
    "Time             : #{@t} years\n"     \
    "Rate             : #{RATE * 100}% pa\n" \
    "Simple Interest  : #{format('%.2f', simple_interest)}\n"   \
    "Compound Interest: #{format('%.2f', compound_interest)}\n" \
    "Difference       : #{difference}"
  end
end

puts Interest.new(ARGV[0], ARGV[1]).to_s