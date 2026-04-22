OPERATIONS = {
  ":+" => :+,
  ":-" => :-,
  ":*" => :*,
  ":/" => :/
}.freeze

module Calculable
  def calculate(*args)
    raise ArgumentError, "Please provide an input" if args.empty?

    a, op, b = parse_input(args.join(","))
    compute(a, op, b)
  end

  private

  def parse_input(input)
    a, op, b = input.split(",").map(&:strip)
    raise ArgumentError, "Invalid format" unless a && op && b

    [a.to_r, op, b.to_r] 
  end

  def compute(a, op, b)
    raise ArgumentError, "Unsupported operator: #{op}" unless OPERATIONS.key?(op)
    raise ZeroDivisionError, "Cannot divide by zero" if op == ":/" && b.zero?

    result = a.public_send(OPERATIONS[op], b)
    rationalize(result)
  end

  def rationalize(result)
    result = result.to_f
    result.finite? ? (result % 1).zero? ? result.to_i : result.round(10) : raise("Math error: result is not finite")
  end
end

class Calculator
  include Calculable

  def self.run(*args)
    new.calculate(*args)
  end
end

if ARGV.any?
  input = ARGV.join(",")
  puts Calculator.run(input)
else
  puts "Please provide an input"
end