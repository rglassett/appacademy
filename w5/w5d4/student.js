var Course = function(courseName, department, credits){
  this.courseName = courseName;
  this.department = department;
  this.credits = credits;
  this.students = [];
}

Course.prototype.addStudent = function(student){
  student.enroll(this);
}

var Student = function(fname, lname){
  this.fname = fname;
  this.lname = lname;
};

Student.prototype.name = function(){
  return this.fname + " " + this.lname;
};

Student.prototype.courses = function(){
  return this.courses;
};

Student.prototype.enroll = function(course){
  if (this.courses.indexOf(course) === -1){
    this.courses.push(course);
    course.students.push(this);
  }
};

Student.prototype.courseLoad = function(){
  var hash = {};
  
};

module.exports = Student;