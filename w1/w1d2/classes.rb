class Student
  attr_accessor :first, :last, :courses
  def initialize(first, last)
    @first = first
    @last = last
    @courses = []
  end
  
  def enroll(course)
    courses << course
    course.add_student(self)
  end
  
  def course_load
    hash = Hash.new(0)
    
    courses.each do |course|
      hash[course.department] += course.credits
    end
    
    hash
  end

  def has_conflict?
    conflict = false
    courses.each do |course1|
      courses.each do |course2|
        if course1 != course2 && course1.conflicts_with?(course2)
          conflict = true
          return true
        end
      end
    end
    conflict
  end

end

class Course
  
  attr_accessor :name, :department, :credits, :students, :days, :time
  
  def initialize(name, department, credits, days, time)
    @name = name
    @department = department
    @credits = credits
    @students = []
    @days = days
    @time = time
  end
  
  def add_student(student)
    @students << student
  end
  
  def conflicts_with?(course)
    if time == course.time && days.any? { |day| course.days.include?(day) }
      true
    else
      false
    end
  end
  
end

s = Student.new("Dude", "Mang")

c = Course.new("Basket-Weaving", "Arts", 2, [:mon, :tue, :wed], 1)

d = Course.new("Monkey-Patching", "Computer Science", 3, [:wed, :thu, :fri], 1)
s.enroll(c)
p s.course_load

s.enroll(d)
p s.course_load

p s.has_conflict?