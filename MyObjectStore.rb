module MyObjectStore
  def self.included(base)
    base.instance_variable_set(:@store, [])
    base.extend(ClassMethods)
  end

  module ClassMethods
    def store
      @store
    end

    def validate_presence_of(*fields)
      @presence_fields = fields
    end

    def presence_fields
      @presence_fields || []
    end

    def count
      @store.size
    end

    def collect
      @store.each
    end

    def method_missing(name, *args)
      if name.to_s.start_with?("find_by_")
        attribute = name.to_s.sub("find_by_", "")
        find_by(attribute, args.first)
      else
        super
      end
    end

    def respond_to_missing?(name, include_private = false)
      name.to_s.start_with?("find_by_") || super
    end

    private

    def find_by(attribute, value)
      Enumerator.new do |yielder|
        @store.each do |obj|
          yielder << obj if obj.respond_to?(attribute) &&
                            obj.public_send(attribute).to_s == value.to_s
        end
      end
    end
  end

  def save
    @errors = []

    validate_presence
    validate if respond_to?(:validate)

    if @errors.empty?
      self.class.store << self
    else
      puts "Object not saved:"
      @errors.each { |e| puts "  - #{e}" }
    end
  end

  def valid?
    @errors = []
    validate_presence
    validate if respond_to?(:validate)
    @errors.empty?
  end

  def errors
    @errors ||= []
  end

  private

  def validate_presence
    self.class.presence_fields.each do |field|
      value = respond_to?(field) ? public_send(field) : nil
      @errors << "#{field} can't be blank" if value.nil? || value.to_s.strip.empty?
    end
  end
end


class Play
  include MyObjectStore

  attr_accessor :fname, :lname, :age, :email

  validate_presence_of :fname, :email

  def validate
    @errors ||= []
    @errors << "Email must contain @" if email && !email.include?("@")
  end
end


p1 = Play.new
p1.fname = "Alice"
p1.email = "alice@example.com"
p1.save

p2 = Play.new
p2.fname = "xyz"
p2.email = "xyz@example.com"
p2.save

p3 = Play.new
p3.email = "notvalid"
p3.save

p4 = Play.new
p4.fname = "Bob"
p4.email = "bob@example.com"
puts p4.valid?

puts Play.count

Play.collect.each { |o| puts o.fname }

Play.find_by_fname("xyz").each  { |o| puts o.email }
Play.find_by_email("alice@example.com").each { |o| puts o.fname }