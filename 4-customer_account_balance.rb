if ARGV.empty?
  warn "Please provide an input"
  exit 1
end

class Account
  @@count = 0

  attr_reader :account_no, :name, :balance

  def initialize(name, balance)
    @@count += 1
    @account_no = @@count
    @name       = name
    @balance    = Integer(balance)
  end

  def deposit(amount)
    raise ArgumentError, "Amount must be positive" unless amount.positive?
    @balance += amount
  end

  def withdraw(amount)
    raise ArgumentError, "Amount must be positive" unless amount.positive?
    raise "Insufficient funds" if amount > @balance
    @balance -= amount
  end

  def to_s
    "Account number  : #{@account_no}\n" \
    "Account holder  : #{@name}\n" \
    "Account balance : #{@balance}"
  end
end

class InputParser
  ENTRY = /\A([^:]+):(.+)\z/

  def self.parse(args)
    parts = args.map { |arg| parse_entry(arg) }
    {
      name1:    parts[0][0],
      balance1: parts[0][1],
      name2:    parts[1][0],
      balance2: parts[1][1],
      amount:   Integer(parts[2][1])
    }
  end

  def self.parse_entry(arg)
    match = ENTRY.match(arg)
    raise ArgumentError, "Invalid input format: #{arg}" unless match
    [match[1].strip, match[2].strip]
  end
end

data = InputParser.parse(ARGV)

acc1 = Account.new(data[:name1], data[:balance1])
acc2 = Account.new(data[:name2], data[:balance2])

acc1.withdraw(data[:amount])
acc2.deposit(data[:amount])

puts acc1
puts
puts acc2