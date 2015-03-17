class Employee
  attr_reader :name, :title, :salary, :boss
  
  def initialize(name, title, salary, boss)
    @name, @title, @salary, @boss = name, title, salary, boss
    @boss.add_employee(self) if @boss
  end
  
  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_reader :employees
  
  def initialize(name, title, salary, boss, employees=[])
    super(name, title, salary, boss)
    @employees = employees
  end
  
  def add_employee(employee)
    @employees << employee unless @employees.include?(employee)
  end
  
  def bonus(multiplier)
    team_salary * multiplier
  end
  
  def team_salary
    total_salaries = @salary
    
    @employees.each do |employee|
      if employee.is_a?(Manager)
        total_salaries += employee.team_salary
      else
        total_salaries += employee.salary
      end
    end
    
    total_salaries
  end
end

ceo = Manager.new("The CEO", "Big Cheese", 500000, nil)
boss = Manager.new("Pointy-Haired Boss", "Senior Manager", 200000, ceo)
dilbert = Employee.new("Dilbert", "Senior Engineer", 80000, boss)
wally = Employee.new("Wally", "Junior Engineer", 60000, boss)
zimbu = Employee.new("Zimbu", "Monkey Intern", 100000, boss)