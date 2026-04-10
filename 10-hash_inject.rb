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

  def group_by_parity
    group_by_length.inject({ odd: [], even: [] }) do |acc, (key, value)|
      if key.odd?
        acc[:odd] << value
      else
        acc[:even] << value
      end
      acc
    end
  end
end

puts eval(ARGV[0]).group_by_parity.inspect