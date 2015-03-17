var sum = function() {
  var args = Array.prototype.slice.call(arguments);
  var total = 0;
  for (var i = 0; i < args.length; i++) {
    total += args[i];
  }
  return total;
};

// console.log(sum(1, 2, 3, 4));
// console.log(sum(1, 2, 3, 4, 5));

Function.prototype.myBind = function(context) {
  var fn = this;
  var args = [].slice.call(arguments, 1);
  return function () {
    var innerArgs = Array.prototype.slice.call(arguments);
    return fn.apply(context, args.concat(innerArgs));
  };
};

var otherBoundFunction = sum.bind(this, 1, 2);
var myBoundFunction = sum.myBind(this, 1, 1);

// equivalent to `obj.myFunction(1, 2, 3)`
console.log(otherBoundFunction(3));
console.log(myBoundFunction(3));