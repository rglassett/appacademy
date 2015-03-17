var sum = function() {
  var args = Array.prototype.slice.call(arguments);
  var total = 0;
  for (var i = 0; i < args.length; i++) {
    total += args[i];
  }
  return total;
};

var curriedSum = function (numArgs) {
  var numbers = [];
  var _curriedSum = function (number) {
    numbers.push(number);
    
    if (numbers.length === numArgs) {
      return sum.apply(this, numbers);
    } else {
      return _curriedSum;
    }
  };
  return _curriedSum;
};

// var testSum = curriedSum(5);
// console.log(testSum(1)(3)(5)(7)(10));

Function.prototype.curry = function (numArgs) {
  var args = [];
  var fn = this;
  var _curriedFunction = function (arg) {
    args.push(arg);
    
    if (args.length === numArgs) {
      return fn.apply(this, args);
    } else {
      return _curriedFunction;
    }
  };
  return _curriedFunction;
};

var addStudents = function() {
  students = [].slice.call(arguments)
  for(var i = 0; i< students.length; i++) {
    console.log(students[i])
  }
}

var f1 = sum.curry(3);
var f2 = f1(4);
var f3 = f2(20);
var result = f3(6);

console.log(result);

var curryStudents = addStudents.curry(3)

console.log(curryStudents("Adam"))
console.log(curryStudents("Adam"))
console.log(curryStudents("Adam"))
