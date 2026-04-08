if ARGV.length == 0
  puts "Please provide an input"
  exit
end

n = ARGV[0].to_i

def pascal(n)
  return if n <= 0

  row = [1]

  (1..n).each do
    yield row   

    new_row = [1]

    (0...row.length - 1).each do |i|
      new_row << row[i] + row[i + 1]
    end

    new_row << 1 if row.length > 0
    row = new_row
  end
end

pascal(n) do |row|
  puts row.join(" ")
end