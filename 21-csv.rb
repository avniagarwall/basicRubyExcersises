require 'csv'

class EmployeeReport
  INPUT_FILE  = "input.csv"
  OUTPUT_FILE = "output.txt"

  def initialize
    @employees = Hash.new { |h, k| h[k] = [] }
  end

  def load
    raise "Input file '#{INPUT_FILE}' not found" unless File.exist?(INPUT_FILE)

    CSV.foreach(INPUT_FILE, headers: true, header_converters: :symbol) do |row|
      designation = row[:designation].to_s.strip
      @employees[designation] << {
        name: row[:name].to_s.strip,
        id:   row[:empid].to_s.strip
      }
    end

    self
  end

  def generate
    File.open(OUTPUT_FILE, "w") do |file|
      @employees.sort.each do |designation, people|
        file.puts pluralize(designation, people.length)
        people.sort_by { |p| p[:name] }.each do |p|
          file.puts "#{p[:name]} (EmpId: #{p[:id]})"
        end
      end
    end

    puts "Report written to #{OUTPUT_FILE}"
    self
  end

  private

  def pluralize(word, count)
    count > 1 ? "#{word}s" : word
  end
end

begin
  EmployeeReport.new.load.generate
rescue => e
  puts "Error: #{e.message}"
end