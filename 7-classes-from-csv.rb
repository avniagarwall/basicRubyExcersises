require 'csv'

class CSVClassFactory
  def self.build(filepath)
    validate!(filepath)

    class_name = extract_class_name(filepath)
    headers, rows = parse_csv(filepath)
    klass = create_class(headers)

    Object.const_set(class_name, klass)

    objects = rows.map { |row| klass.new(row) }

    display(class_name, objects)
  end

  private

  def self.validate!(filepath)
    raise ArgumentError, "File not found: #{filepath}" unless File.exist?(filepath)
    raise ArgumentError, "Not a CSV file"               unless filepath.end_with?(".csv")
  end

  def self.extract_class_name(filepath)
    File.basename(filepath, ".csv")
        .split(/[_\s]/)
        .map(&:capitalize)
        .join
  end

  def self.parse_csv(filepath)
    table   = CSV.read(filepath, headers: true)
    headers = table.headers
    rows    = table.map(&:to_h)
    [headers, rows]
  end

  def self.create_class(headers)
    Class.new do
      attr_reader(*headers)

      define_method(:initialize) do |row|
        headers.each do |header|
          instance_variable_set("@#{header}", row[header])
        end
      end

      define_method(:display) do
        puts "-" * 30
        headers.each do |h|
          puts "  #{h.ljust(10)}: #{send(h)}"
        end
        puts "-" * 30
      end
    end
  end

  def self.display(class_name, objects)
    puts "\nClass Created : #{class_name}"
    puts "Total Records : #{objects.size}"
    puts "\nAll Records:"
    objects.each_with_index do |obj, i|
      puts "\nRecord ##{i + 1}:"
      obj.display
    end
  end
end

filepath = "persons.csv"
CSVClassFactory.build(filepath)