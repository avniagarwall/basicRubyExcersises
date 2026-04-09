require 'csv'

employees = {}

CSV.foreach("input.csv", headers: true, header_converters: :symbol) do |row|
  name = row[:name].to_s.strip
  id = row[:empid].to_s.strip
  designation = row[:designation].to_s.strip

  employees[designation] ||= []
  employees[designation] << { name: name, id: id }
end

sorted = employees.sort.to_h

File.open("output.txt", "w") do |file|
  sorted.each do |designation, people|
    
    title = people.length > 1 ? "#{designation}s" : designation
    file.puts title

    people.sort_by { |p| p[:name] }.each do |p|
      file.puts "#{p[:name]} (EmpId: #{p[:id]})"
    end
  end
end