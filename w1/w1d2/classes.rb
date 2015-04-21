class Student
  attr_reader :first, :last, :courses

  def initialize(first, last)
    @first = first
    @last = last
    @courses = []
  end

  def course_load
    hash = Hash.new { |h, k| h[k] = 0 }

    courses.each do |course|
      hash[course.department] += course.credits
    end

    hash
  end

  def enroll(course)
    if has_conflict?(course)
      raise "Can't enroll in a course that would create a conflict!"
    end

    courses << course
    course.students << self
  end

  def has_conflict?(course)
    courses.any? { |enrolled_course| enrolled_course.conflicts_with?(course) }
  end

  def name
    "#{first} #{last}"
  end
end

class Course
  attr_reader :name, :department, :credits, :students, :days, :time

  def initialize(name, department, credits, days, time)
    @name = name
    @department = department
    @credits = credits
    @students = []
    @days = days
    @time = time
  end

  def add_student(student)
    student.enroll(self)
  end

  def conflicts_with?(course)
    time == course.time && days.any? { |day| course.days.include?(day) }
  end
end
