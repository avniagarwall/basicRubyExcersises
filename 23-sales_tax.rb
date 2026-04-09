class Item
  attr_accessor :name, :imported, :exempted, :price

  def initialize(name, imported, exempted, price)
    @name = name
    @imported = imported
    @exempted = exempted
    @price = price
  end

  def tax
    tax = 0

    # 10% basic tax if not exempted
    tax += 0.10 * @price unless @exempted

    # 5% import duty
    tax += 0.05 * @price if @imported

    tax
  end

  def final_price
    @price + tax
  end
end

items = []

loop do
  print "Name of the product: "
  name = gets.chomp

  print "Imported? (yes/no): "
  imported = gets.chomp.downcase == "yes"

  print "Exempted from sales tax? (yes/no): "
  exempted = gets.chomp.downcase == "yes"

  print "Price: "
  price = gets.chomp.to_f

  items << Item.new(name, imported, exempted, price)

  print "Do you want to add more items to your list(y/n): "
  break if gets.chomp.downcase == "n"
end

puts "\n----- BILL -----"

total = 0

items.each do |item|
  item_total = item.final_price
  total += item_total

  puts "#{item.name}: #{item_total.round(2)}"
end

puts "----------------"
puts "Grand Total: #{total.round}"