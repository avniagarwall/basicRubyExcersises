class Item
  SALES_TAX_RATE  = 0.10
  IMPORT_DUTY_RATE = 0.05

  attr_reader :name, :price, :imported, :exempted

  def initialize(name:, price:, imported:, exempted:)
    @name     = name
    @price    = Float(price)
    @imported = imported
    @exempted = exempted
  end

  def tax
    tax = 0.0
    tax += @price * SALES_TAX_RATE  unless @exempted
    tax += @price * IMPORT_DUTY_RATE if @imported
    tax
  end

  def total_price
    @price + tax
  end

  def to_s
    "#{@name}#{' (imported)' if @imported}: #{format('%.2f', total_price)} (tax: #{format('%.2f', tax)})"
  end
end

class ShoppingCart
  def initialize
    @items = []
  end

  def add(item)
    @items << item
  end

  def grand_total
    @items.sum(&:total_price).round
  end

  def total_tax
    @items.sum(&:tax)
  end

  def display
    puts "\n--- Receipt ---"
    @items.each { |item| puts item }
    puts "---------------"
    puts "Total Tax   : #{format('%.2f', total_tax)}"
    puts "Grand Total : #{grand_total}"
  end
end

class InputCollector
  def self.yes?(prompt)
    print prompt
    gets.chomp.strip.downcase == 'yes'
  end

  def self.ask(prompt)
    print prompt
    gets.chomp.strip
  end

  def self.collect
    cart = ShoppingCart.new

    loop do
      name     = ask("Name of the product: ")
      imported = yes?("Imported? (yes/no): ")
      exempted = yes?("Exempted from sales tax? (yes/no): ")
      price    = ask("Price: ")

      cart.add(Item.new(name: name, price: price, imported: imported, exempted: exempted))

      break unless ask("Do you want to add more items to your list(y/n): ").downcase == 'y'
    end

    cart
  end
end

begin
  cart = InputCollector.collect
  cart.display
rescue Interrupt
  puts "\nExiting..."
rescue => e
  puts "Error: #{e.message}"
end