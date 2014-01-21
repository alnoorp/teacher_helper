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

class Student
  attr_reader :id, :first_name, :last_name, :grades

  def initialize(id, first_name, last_name, grades)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @grades = grades  # initialize to empty array [] (fix conversion above)
  end

  def calc_average
    AssignmentGrade.new(@grades).calc_average
  end

  def assign_grade
    AssignmentGrade.new(@grades).assign_grade
  end

end

class AssignmentGrade

  def initialize(grades)
    @grades = grades
  end

  def calc_average
    @grades.inject(:+) / @grades.length
  end

  def assign_grade
    if calc_average >= 90
      'A'
    elsif calc_average < 90 && calc_average >= 80
      'B'
    elsif calc_average < 80 && calc_average >=70
      'C'
    elsif calc_average < 70 && calc_average >= 60
      'D'
    else
      'F'
    end
  end

end

module Enumerable

    def sum
      self.inject(0){|accum, i| accum + i }
    end

    def mean
      self.sum/self.length.to_f
    end

    def sample_variance
      m = self.mean
      sum = self.inject(0){|accum, i| accum +(i-m)**2 }
      sum/(self.length - 1).to_f
    end

    def standard_deviation
      return Math.sqrt(self.sample_variance)
    end

end

class GradeSummary

  def initialize(class_list)
    @class_list = class_list
  end

  def teach_report
    @class_list.each do |student|
      puts "#{student.first_name} #{student.last_name} - #{student.calc_average}, #{student.assign_grade}"
    end
  end

  def create_report_file
    CSV.open('class_report.csv', 'w') do |row|
      row << [ 'First Name', 'Last Name', 'Average', 'Grade' ]
    end
    CSV.open('class_report.csv', 'a') do |row|
      @class_list.each do |student|
        row << [ student.first_name, student.last_name, student.calc_average, student.assign_grade ]
      end
    end
  end

  def class_summary
    grade_array = []
    @class_list.each do |student|
      grade_array << student.calc_average.to_f
    end
    sum = grade_array.inject(:+)
    average = sum / grade_array.length
    min_grade = grade_array.min
    max_grade = grade_array.max
    std_grade = grade_array.standard_deviation
    puts "Class Average: #{average}"
    puts "Min Grade: #{min_grade}"
    puts "Max Grade: #{max_grade}"
    puts "Standard Deviation: #{std_grade.round(2)}"
  end

end

file_name = 'class_list.csv'
grade_reader = GradeReader.new(file_name)
grade_data = grade_reader.parse
puts
puts 'Students Test Scores'
puts '--------------------'
grade_list = grade_reader.class_list
puts
puts 'Grade Summary'
puts '-------------'
report = GradeSummary.new(grade_list).teach_report
GradeSummary.new(grade_list).create_report_file
puts
puts 'Class Summary'
puts '-------------'
class_average = GradeSummary.new(grade_list).class_summary
