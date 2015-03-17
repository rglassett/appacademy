Array.prototype.doubleArray = function() {
  var resultsArray = [];
  for(var i = 0; i < this.length; i++){
    resultsArray.push(this[i] * 2);
  }
  return resultsArray;
};

//console.log(doubleArray([1, 2, 3, 4, 5]));

Array.prototype.myEach = function(func) {
  for(var i = 0; i < this.length; i++){
    func(this[i]);
  }
  return this;
};

console.log([1, 2, 3, 4].myEach(console.log));

Array.prototype.myMap = function(func) {
  var resultsArray = [];
  
  this.myEach(function(el) { 
    resultsArray.push(func(el));
  });

  return resultsArray;
};

Array.prototype.myInject = function(func) {
  var accumulator = this[0];
  
  this.slice(1).myEach(function(el) { 
    accumulator = func(accumulator, el);
  });

  return accumulator;
};

var double = function(accum, num) {
  return accum + (num * 2);
};

console.log([1, 2, 3, 4].myMap(double));

console.log([1, 2, 3, 4].myInject(double));