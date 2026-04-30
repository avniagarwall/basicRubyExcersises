require 'csv'

class CSVLoader
  def initialize(filepath)
    raise ArgumentError, "File not found: #{filepath}" unless File.exist?(filepath)
    raise ArgumentError, "Not a CSV file"               unless filepath.end_with?(".csv")

    @filepath = filepath
  end

  def load
    headers, rows = parse_csv
    klass         = build_class(headers)
    build_objects(klass, headers, rows)
  end

  private

  def parse_csv
    table   = CSV.read(@filepath, headers: true)
    headers = table.headers
    rows    = table.map(&:to_h)
    [headers, rows]
  end

  def build_class(headers)
    klass = Class.new do
      attr_accessor(*headers)

      define_method(:initialize) do |row|
        headers.each { |h| send("#{h}=", row[h]) }
      end
    end

    class_name = File.basename(@filepath, ".csv")
                     .split(/[_\s]/)
                     .map(&:capitalize)
                     .join

    Object.const_set(class_name, klass)
  end

  def build_objects(klass, headers, rows)
    rows.map { |row| klass.new(row) }
  end
end


objects = CSVLoader.new("persons.csv").load
objects.each do |obj|
  puts obj.name
end