if ARGV.length == 0
  puts "Please provide an input"
  exit
end

class Account
  @@count = 0

  attr_reader :account_no, :name, :balance

  def initialize(name, balance)
    @@count += 1
    @account_no = @@count
    @name = name
    @balance = balance.to_i
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end

input = ARGV.join(" ")
parts = input.scan(/"[^"]+"|\S+/)

name1, bal1 = parts[0].gsub('"','').split(":")
name2, bal2 = parts[1].gsub('"','').split(":")
amount = parts[2].split(":")[1].to_i

acc1 = Account.new(name1, bal1)
acc2 = Account.new(name2, bal2)

acc1.withdraw(amount)
acc2.deposit(amount)

puts "Account number: #{acc1.account_no}"
puts "Account holder name: #{acc1.name}"
puts "Account balance: #{acc1.balance}"

puts "Account number: #{acc2.account_no}"
puts "Account holder name: #{acc2.name}"
puts "Account balance: #{acc2.balance}"