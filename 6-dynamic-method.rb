class SuperString < String

  def exclude?(substring)
    !include?(substring)
  end

  def palindrome?
    self == self.reverse
  end

  def truncate(max_length, omission = "...")
    length > max_length ? self[0, max_length] + omission : self
  end

  def repeat(times = 2, separator = " ")
    ([self] * times).join(separator)
  end

  def word_count(word = nil)
    words = split
    word ? words.count { |w| w.downcase == word.downcase } : words.size
  end

  def titleize
    split.map(&:capitalize).join(" ")
  end

  def remove(substring, global = true)
    global ? gsub(substring, "") : sub(substring, "")
  end
end


# ── Method Metadata ──
METHOD_INFO = {
  exclude?:   { args: [{ name: "substring",  required: true  }] },
  palindrome?: { args: [] },
  truncate:   { args: [{ name: "max_length", required: true  },
                       { name: "omission",   required: false, default: "..." }] },
  repeat:     { args: [{ name: "times",      required: false, default: 2     },
                       { name: "separator",  required: false, default: " "   }] },
  word_count: { args: [{ name: "word",       required: false, default: nil   }] },
  titleize:   { args: [] },
  remove:     { args: [{ name: "substring",  required: true  },
                       { name: "global",     required: false, default: true  }] }
}.freeze


# ── CLI ──
class CLI
  CUSTOM_METHODS = METHOD_INFO.keys

  def run
    obj    = create_object
    method = prompt_method
    args   = prompt_args(method)
    execute(obj, method, args)
  end

  private

  def create_object
    print "\nEnter an input string: "
    input = gets.chomp
    SuperString.new(input)
  end

  def prompt_method
    puts "\n#{"=" * 40}"
    puts "Available Methods:"
    puts "=" * 40
    CUSTOM_METHODS.each_with_index do |m, i|
      args    = METHOD_INFO[m][:args]
      arg_str = args.map do |a|
        a[:required] ? "<#{a[:name]}>" : "[#{a[:name]}=#{a[:default].inspect}]"
      end.join(", ")
      puts "  #{i + 1}. #{m}(#{arg_str})"
    end
    puts "=" * 40

    print "\nEnter method name to call: "
    method = gets.chomp.to_sym

    unless CUSTOM_METHODS.include?(method)
      puts "Error: Unknown method '#{method}'"
      exit
    end

    method
  end

  def prompt_args(method)
    args_info = METHOD_INFO[method][:args]
    return [] if args_info.empty?

    args = []
    args_info.each do |arg|
      if arg[:required]
        print "Enter required argument '#{arg[:name]}': "
      else
        print "Enter optional argument '#{arg[:name]}' (default: #{arg[:default].inspect}, press enter to skip): "
      end

      input = gets.chomp

      if input.empty? && !arg[:required]
        args << arg[:default]
      else
        args << cast(input)
      end
    end

    args
  end

  def cast(value)
    return true  if value == "true"
    return false if value == "false"
    return nil   if value == "nil"
    return value.to_i if value.match?(/^\d+$/)
    value
  end

  def execute(obj, method, args)
    puts "\n#{"=" * 40}"
    puts "Executing: #{obj.inspect}.#{method}(#{args.map(&:inspect).join(", ")})"
    puts "=" * 40

    result = obj.public_send(method, *args)

    puts "Result: #{result.inspect}"
  end
end

CLI.new.run