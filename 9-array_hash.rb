if ARGV.length == 0 || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

arr = eval(ARGV[0])

class Array
  def group_by_length
    result = {}

    self.each do |elem|
      str = elem.to_s
      len = str.length

      result[len] ||= []
      result[len] << str
    end

    Hash[result.sort]
  end
end

puts arr.group_by_length