class MyString < String
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


module MethodPrompt
  def prompt_method(target_class)
    puts "\nAvailable Methods:"
    target_class.instance_methods(false).each_with_index do |m, i|
      params    = target_class.instance_method(m).parameters
      param_str = params.map { |type, name| type == :req ? "<#{name}>" : "[#{name}]" }.join(", ")
      puts "  #{i + 1}. #{m}(#{param_str})"
    end

    print "\nEnter method name to call: "
    gets.chomp.to_sym
  end
end


module ArgPrompt
  def prompt_args(target_class, method)
    params = target_class.instance_method(method).parameters
    return [] if params.empty?

    params.map do |type, name|
      prompt_single(name, type == :req)
    end
  end

  def prompt_single(name, required)
    loop do
      print required ? "Enter required argument '#{name}': " : "Enter optional argument '#{name}' (press enter to skip): "
      input = gets.chomp
      return cast(input) unless input.empty?
      return nil         unless required
      puts "Argument '#{name}' is required, please enter a value."
    end
  end

  def cast(value)
    return true  if value == "true"
    return false if value == "false"
    return nil   if value == "nil"
    return value.to_i if value.match?(/\A\d+\z/)
    value
  end
end


class StringRunner
  include MethodPrompt
  include ArgPrompt

  def initialize(target_class)
    @target_class = target_class
  end

  def run
    print "\nEnter an input string: "
    obj = @target_class.new(gets.chomp)

    method = prompt_method(@target_class)

    unless @target_class.instance_methods(false).include?(method)
      puts "Unknown method '#{method}'"
      return
    end

    args   = prompt_args(@target_class, method)
    result = obj.public_send(method, *args)

    puts "\nResult: #{result.inspect}"
  end
end


StringRunner.new(MyString).run