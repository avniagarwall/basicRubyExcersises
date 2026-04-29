class InteractiveProgram
  def initialize(bind)
    @binding = bind
    @buffer  = []
  end

  def run
    puts "Interactive Ruby Program"
    puts "Enter a blank line to evaluate."
    puts "Enter 'q' to quit."
    puts "-" * 40

    loop do
      print ">> "
      line = gets.chomp

      case line
      when "q"
        puts "Goodbye!"
        break

      when ""
        evaluate

      else
        @buffer << line
      end
    end
  end

  private

  def evaluate
    return if @buffer.empty?

    code = @buffer.join("\n")
    @buffer.clear

    begin
      result = @binding.eval(code)
      puts "=> #{result.inspect}"
    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  end
end

InteractiveProgram.new(binding).run