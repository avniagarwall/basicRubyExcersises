if ARGV.empty? || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

class Array
  def reverse_iterate
    i = length - 1
    while i >= 0
      yield self[i]
      i -= 1
    end
  end
end

puts eval(ARGV[0]).reverse_iterate { |i| print "#{i} " }