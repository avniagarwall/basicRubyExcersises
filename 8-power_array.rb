if ARGV.empty? || ARGV[0].strip.empty?
  puts "Please provide an input"
  exit
end

class Array
  def group_by_length
    result = Hash.new { |h, k| h[k] = [] }

    each do |element|
      key = element.to_s.length
      result[key] << element.to_s
    end

    result.sort.to_h
  end
end

puts eval(ARGV[0]).group_by_length.inspect
