class DynamicClass
  def initialize(class_name)
    @class_name = class_name
    @klass = Object.const_set(class_name, Class.new)
  end

  def def_method(method_name, method_body)
    @klass.define_method(method_name) do
      eval(method_body)
    end
  end

  def call(method_name)
    instance = @klass.new
    instance.public_send(method_name)
  end
end


print "Please enter the class name: "
class_name = gets.chomp

my_class = DynamicClass.new(class_name)

print "Please enter the method name you wish to define: "
method_name = gets.chomp

print "Please enter the method's code: "
method_body = gets.chomp

my_class.def_method(method_name, method_body)

puts "Hello, Your class #{class_name} with method #{method_name} is ready. Calling: #{class_name}.new.#{method_name}:"
puts my_class.call(method_name).inspect