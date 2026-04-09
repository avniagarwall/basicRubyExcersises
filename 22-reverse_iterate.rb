if ARGV.length == 0 || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

class Array
  def reverse_iterate
    i = self.length - 1

    while i >= 0
      yield self[i]
      i -= 1
    end
  end
end

arr = eval(ARGV[0])

arr.reverse_iterate do |i|
  print "#{i} "
end

puts