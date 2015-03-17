Function.prototype.myBind = function (context) {
  var fn = this;
  return function () {
    return fn.apply(context);
  };
};

function times(num, fun) {
  for (var i = 0; i < num; i++) {
    fun(); // call is made "function-style"
  }
}

var cat = {
  age: 5,

  ageOneYear: function () {
    this.age += 1;
  }
};

// Function argument is different:
// times(10, function () {
//   cat.ageOneYear();
// });
//
console.log(cat.age);
times(10, cat.ageOneYear.myBind(cat));
console.log(cat.age);
times(10, cat.ageOneYear.bind(cat));
console.log(cat.age);