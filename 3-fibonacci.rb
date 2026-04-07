if ARGV.length == 0
  puts "Please provide an input"
  exit
end

limit = ARGV[0].to_i

def fibonacci(limit)
  a = 1
  b = 1

  yield a
  yield b

  while true
    c = a + b
    break if c > limit
    yield c
    a = b
    b = c
  end
end

fibonacci(limit) { |num| print "#{num} " }