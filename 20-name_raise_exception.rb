if ARGV.length < 2
  puts "Please provide an input"
  exit
end

module NameError
  class BlankNameError    < StandardError; end
  class InvalidCaseError  < StandardError; end
end

class Name
  attr_reader :firstname, :lastname

  def initialize(firstname, lastname)
    @firstname = validate_firstname(firstname)
    @lastname  = validate_lastname(lastname)
  end

  def to_s
    "#{@firstname} #{@lastname}"
  end

  private

  def validate_firstname(name)
    raise NameError::BlankNameError,   "First name cannot be blank"              if name.strip.empty?
    raise NameError::InvalidCaseError, "First name must start with a capital letter" unless name[0] =~ /[A-Z]/
    name
  end

  def validate_lastname(name)
    raise NameError::BlankNameError, "Last name cannot be blank" if name.strip.empty?
    name
  end
end

begin
  puts Name.new(ARGV[0], ARGV[1]).to_s
rescue NameError::BlankNameError => e
  puts "Blank Name Error: #{e.message}"
rescue NameError::InvalidCaseError => e
  puts "Invalid Case Error: #{e.message}"
end