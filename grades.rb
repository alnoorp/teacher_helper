class GradeReader

  def load_grades
  end

  def list_students_grades
  end

end

class AssignmentGrade

  def calc_average
  end

  def list_students_average
  end

  def assign_grade
  end
end

class FinalGrade

  def initialize
  end

  def average
  end
end

class Student
  attr_reader :id, :first_name, :last_name, :grades

  def initialize(id, first_name, last_name, grades = [])
    @id = id
    @first_name = first_name
    @last_name = last_name
    @grades = grades
  end

  def name
    puts first_name + ' ' + last_name
  end

  def calc_average
    average = grades.inject { |sum, x| sum + x }.to_f / grades.size
  end

  def assign_grade
    if calc_average >= 90
      puts letter_grade = 'A'
    elsif calc_average < 90 && calc_average >= 80
      puts letter_grade = 'B'
    elsif calc_average < 80
      puts letter_grade = 'C'
    elsif calc_average < 70
      puts letter_grade = 'D'
    else
      puts letter_grade = 'E'
    end
  end

end

class GradeSummary

  def write_grade_file
  end

  def teach_report
  end
end

file = [ { id: '001', first_name: 'Johnny', last_name: 'Smith', grades: [100, 80, 75, 78, 60] },
   { id: '002', first_name: 'Sally', last_name: 'Strong', grades: [100, 100, 90, 95, 85] }
]

student_group = []
file.each do |row|
  student_group << row
end

student001 = Student.new( '001', 'Johnny', 'Smith', [100, 80, 75, 78, 60] )
student002 = Student.new( '002', 'Sally', 'Strong', [100, 100, 90, 95, 85] )

require 'pry'
binding.pry
