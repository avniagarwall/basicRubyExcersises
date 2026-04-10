if ARGV.length == 0
  puts "Please provide an input"
  exit 1
end

class Vehicle
  attr_reader :name, :price

  def initialize(name, price)
    @name  = name
    @price = Float(price)
  end

  def to_s
    "Name  : #{@name}\nPrice : #{@price}"
  end
end

class Bike < Vehicle
  attr_reader :dealer, :percent

  def initialize(name, price, dealer, percent)
    super(name, price)
    @dealer  = dealer
    @percent = Float(percent)
  end

  def apply_price_increase
    @price += @price * @percent / 100
  end

  def to_s
    "Name   : #{@name}\nPrice  : #{"%.2f" % @price}\nDealer : #{@dealer}"
  end
end

class InputParser
  QUOTED_OR_WORD = /"([^"]+)"|(\S+)/

  def self.parse(args)
    parts = args.join(" ").scan(QUOTED_OR_WORD).map { |q, w| q || w }
    raise ArgumentError, "Expected 4 arguments: name price dealer percent" if parts.length < 4
    {
      name:    parts[0],
      price:   parts[1],
      dealer:  parts[2],
      percent: parts[3]
    }
  end
end

data = InputParser.parse(ARGV)

bike = Bike.new(data[:name], data[:price], data[:dealer], data[:percent])

puts bike
puts
puts "After #{bike.percent}% price increase:"
puts

bike.apply_price_increase
puts bike