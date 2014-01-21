require 'csv'

class GradeReader

  def initialize(file_name)
    raise "#{file_name} does not exist" unless File.exists? file_name
    raise "Wrong file type (extension)" unless File.extname(file_name) == '.csv'
    @grade_array = []
    CSV.foreach(file_name, headers: true) do |student|
      @grade_array << student['grades'].split(',').length
    end
    raise "There are missing grades" unless @grade_array.min == @grade_array.max
    @file_name = file_name
  end

  def parse
    @class_list = []
    CSV.foreach(@file_name, headers: true) do |student|
      @class_list << Student.new(
        student['id'],
        student['first_name'],
        student['last_name'],
        student['grades'].split(',').map! { |i| i.to_f }
        )
    end
    @class_list = @class_list.sort_by! { |record| [record.last_name, record.first_name] }
  end

  def class_list
    @class_list.each do |student|
      puts "#{student.first_name} #{student.last_name} - #{student.grades.join(', ')}"
    end
  end

end
