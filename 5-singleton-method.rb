puts "=" * 40
puts "Approach 1: def something.method_name"
puts "=" * 40

str1 = String.new("Hello")

def str1.shout
  upcase + "!!!"
end

puts str1.shout

str2 = String.new("World")
begin
  puts str2.shout
rescue NoMethodError => e
  puts "Error: #{e.message}"
end


puts "\n" + "=" * 40
puts "Approach 2: class << self"
puts "=" * 40

str3 = String.new("Hello")

class << str3
  def shout
    upcase + "!!!"
  end

  def whisper
    downcase + "..."
  end
end

puts str3.shout
puts str3.whisper

str4 = String.new("World")
begin
  puts str4.shout
rescue NoMethodError => e
  puts "Error: #{e.message}"
end