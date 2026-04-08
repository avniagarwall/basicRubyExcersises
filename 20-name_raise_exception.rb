if ARGV.length == 0
  puts "Please provide an input"
  exit
end

class FirstNameError < StandardError; end
class LastNameError < StandardError; end

class Name
  attr_accessor :firstname, :lastname

  def initialize(firstname, lastname)
    raise FirstNameError, "Firstname cannot be blank" if firstname.nil? || firstname.strip.empty?
    raise LastNameError, "Lastname cannot be blank" if lastname.nil? || lastname.strip.empty?

    raise FirstNameError, "Firstname must start with uppercase letter" unless firstname[0] =~ /[A-Z]/

    @firstname = firstname
    @lastname = lastname
  end

  def display
    puts "Your name is #{@firstname} #{@lastname}"
  end
end

begin
  input = ARGV.join(" ")
  parts = input.scan(/"[^"]+"|\S+/).map { |x| x