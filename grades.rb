require 'pry'

require_relative 'grade_reader.rb'
require_relative 'student.rb'
require_relative 'assignment_grade.rb'
require_relative 'grade_summary.rb'

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
