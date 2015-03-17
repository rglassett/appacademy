var Student = require('./student');
var Course = require('./courses');


var ryan = new Student("Ryan", "Glassett");

var ruby101 = new Course("Ruby 101", "Computer Science", 4);
var js101 = new Course("JavaScript 101", "Computer Science", 4);
var cats204 = new Course("Cats 204: Advanced Catting", "Humanities", 3);

console.log(ryan.name());