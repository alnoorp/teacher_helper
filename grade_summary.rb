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
