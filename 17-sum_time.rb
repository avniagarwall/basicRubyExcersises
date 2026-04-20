if ARGV.empty?
  puts "Please provide an input"
  exit
end

class TimeDuration
  TIME_FORMAT = /\A\d{1,2}:\d{1,2}:\d{1,2}\z/
  SECONDS_IN_MINUTE = 60
  SECONDS_IN_HOUR   = 3600
  SECONDS_IN_DAY    = 86400

  def initialize(time_str)
    raise ArgumentError, "Invalid 24-hour time value: #{time_str}" unless time_str.match?(TIME_FORMAT)
    @h, @m, @s = time_str.split(":").map(&:to_i)
    raise ArgumentError, "Invalid 24-hour time value: #{time_str}" if @h >= 24 || @m >= 60 || @s >= 60
  end

  def to_seconds
    @h * SECONDS_IN_HOUR + @m * SECONDS_IN_MINUTE + @s
  end
end

class TimeSummer
  def initialize(time_strings)
    @durations = time_strings.map { |t| TimeDuration.new(t) }
  end

  def sum
    total = @durations.sum(&:to_seconds)

    days    = total / TimeDuration::SECONDS_IN_DAY
    remaining = total % TimeDuration::SECONDS_IN_DAY

    time = Time.mktime(2000, 1, 1) + remaining
    result = time.strftime("%H:%M:%S")

    days > 0 ? "#{days} #{days == 1 ? 'day' : 'days'} & #{result}" : result
  end
end

begin
  puts TimeSummer.new(ARGV).sum
rescue ArgumentError => e
  puts e.message
  exit
end