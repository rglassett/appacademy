var Course = function(courseName, department, credits){
  this.courseName = courseName;
  this.department = department;
  this.credits = credits;
  this.students = [];
}

Course.prototype.addStudent = function(student){
  student.enroll(this);
}

Course.prototype.students = function(){
  this.students;
}

module.exports = Course;