if ARGV.length == 0
  puts "Please provide an input"
  exit
end

class Vehicle
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price.to_f
  end

  def to_s
    "Bike Name: #{@name}\nBike Price: #{@price}"
  end
end

class Bike < Vehicle
  attr_accessor :dealer, :percent_price_increase

  def initialize(name, price, dealer, percent)
    super(name, price)
    @dealer = dealer
    @percent_price_increase = percent.to_f
  end

  def price_increase
    @price = @price + (@price * @percent_price_increase / 100)
  end

  def to_s
    "Bike Name: #{@name}\nBike Price: #{@price}\nBike Dealer: #{@dealer}"
  end
end

input = ARGV.join(" ")
parts = input.scan(/"[^"]+"|\S+/)

name = parts[0].gsub('"', '')
price = parts[1]
dealer = parts[2].gsub('"', '')
percent = parts[3]

bike = Bike.new(name, price, dealer, percent)

puts bike

puts "After #{bike.percent_price_increase} percent hike in price:"
bike.price_increase

puts bike