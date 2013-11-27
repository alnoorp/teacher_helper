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
