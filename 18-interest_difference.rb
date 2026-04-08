if ARGV.length < 2
  puts "Please provide an input"
  exit
end

class Interest
  attr_accessor :p, :t

  def initialize
    @r = 0.10   
    yield self if block_given?
  end

  def difference
    si = @p * (1 + @r * @t)

    ci = @p * (1 + @r) ** @t

    diff = ci - si

    format("%.2f", diff)
  end
end

p = ARGV[0].to_f
t = ARGV[1].to_f

obj = Interest.new do |i|
  i.p = p
  i.t = t
end

puts "Interest difference= #{obj.difference}"