class ShoppingList
  Item = Struct.new(:name, :quantity)

  def initialize
    @items = []
  end

  def items(&block)
    instance_eval(&block)
  end

  def add(name, quantity)
    @items << Item.new(name, quantity)
  end

  def display
    puts "Shopping List"
    puts "-" * 30
    @items.each_with_index do |item, index|
      puts "#{index + 1}. #{item.name} (x#{item.quantity})"
    end
    puts "-" * 30
    puts "Total Items: #{@items.size}"
  end
end

#DSL
sl = ShoppingList.new

sl.items do
  add("Toothpaste", 2)
  add("Computer",   1)
  add("Notebook",   5)
  add("Pen",        10)
end

sl.display