if ARGV.length == 0 || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

n = ARGV[0].to_i

def prime?(num)
  return false if num < 2

  (2..Math.sqrt(num)).step(1) do |i|
    return false if num % i == 0
  end

  true
end

primes = []

(2..n).step(1) do |i|
  primes << i if prime?(i)
end

puts primes.inspect