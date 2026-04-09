if ARGV.length == 0
  puts "Please provide an input"
  exit
end

time_regex = /^\d{1,2}:\d{1,2}:\d{1,2}$/

total_seconds = 0

ARGV.each do |time_str|
  unless time_str.match(time_regex)
    puts "Invalid 24-hour time value"
    exit
  end

  h, m, s = time_str.split(":").map(&:to_i)

  if h >= 24 || m >= 60 || s >= 60
    puts "Invalid 24-hour time value"
    exit
  end

  total_seconds += h * 3600 + m * 60 + s
end

days = total_seconds / (24 * 3600)
remaining = total_seconds % (24 * 3600)

hours = remaining / 3600
remaining %= 3600

minutes = remaining / 60
seconds = remaining % 60

time_result = format("%02d:%02d:%02d", hours, minutes, seconds)

if days > 0
  day_text = days == 1 ? "day" : "days"
  puts "#{days} #{day_text} & #{time_result}"
else
  puts time_result
end