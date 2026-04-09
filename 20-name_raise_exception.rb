if ARGV.length == 0
  puts "Please provide an input"
  exit
end

class FirstNameError < StandardError; end
class LastNameError < StandardError; end

class Name
  def initialize(firstname, lastname)
    raise FirstNameError, "Firstname cannot be blank" if firstname.nil? || firstname.strip.empty?
    raise LastNameError, "Lastname cannot be blank" if lastname.nil? || lastname.strip.empty?

    unless firstname[0] == firstname[0].upcase
      raise FirstNameError, "Firstname must start with uppercase letter"
    end

    @firstname = firstname
    @lastname = lastname
  end

  def display
    "Your name is #{@firstname} #{@lastname}"
  end
end

begin
  input = ARGV.join(" ")
  parts = input.scan(/"[^"]+"|\S+/)

  firstname = parts[0]&.gsub('"', '')
  lastname = parts[1]&.gsub('"', '')

  person = Name.new(firstname, lastname)
  puts person.display

rescue FirstNameError => e
  puts e.message
rescue LastNameError => e
  puts e.message
end