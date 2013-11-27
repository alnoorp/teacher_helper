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
    elsif calc_average < 80
      'C'
    elsif calc_average < 70
      'D'
    else
      'E'
    end
  end

end
