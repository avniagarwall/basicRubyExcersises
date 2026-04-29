class ShoppingList
  class Item
    attr_accessor :name, :quantity

    def initialize(name, quantity)
      @name     = name
      @quantity = quantity
    end

    def to_s
      "#{@name} (x#{@quantity})"
    end
  end

  module Display
    def display
      puts "\nShopping List"
      puts "-" * 30
      @items.each_with_index do |item, index|
        puts "#{index + 1}. #{item}"
      end
      puts "-" * 30
      puts "Total Items: #{@items.size}\n"
    end
  end

  module Management
    def add(name, quantity = 1)
      existing = @items.find { |i| i.name.casecmp?(name) }

      if existing
        existing.quantity += quantity
      else
        @items << Item.new(name, quantity)
      end
    end

    def remove(name)
      removed = @items.reject! { |i| i.name.casecmp?(name) }
      puts "Item '#{name}' not found." unless removed
    end

    def update(name, quantity)
      item = @items.find { |i| i.name.casecmp?(name) }

      if item
        item.quantity = quantity
      else
        puts "Item '#{name}' not found."
      end
    end

    def clear
      @items.clear
      puts "Shopping list cleared."
    end
  end

  include Display
  include Management

  def initialize
    @items = []
  end

  def items(&block)
    instance_eval(&block)
  end
end


# DSL
sl = ShoppingList.new

sl.items do
  add "Toothpaste", 2
  add "Computer",   1
  add "Notebook",   5
  add "Pen",        10
  add "Toothpaste", 3
  remove "Computer"
  update "Pen", 20
end

sl.display