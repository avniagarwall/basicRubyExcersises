if ARGV.empty?
  puts "Please provide an input"
  exit
end

class Pascal
  def initialize(n)
    @n = n.to_i
  end

  def each
    row = [1]
    @n.times do
      yield row
      row = [1] + (0...row.length - 1).map { |i| row[i] + row[i + 1] } + [1]
    end
  end
end

Pascal.new(ARGV[0]).each { |row| puts row.join(" ") }