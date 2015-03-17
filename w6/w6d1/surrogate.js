Function.prototype.inherits = function (parentConstructor) {
  var Surrogate = function () {};
  Surrogate.prototype = parentConstructor.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};

function MovingObject () {}

function Ship () {}
Ship.inherits(MovingObject);

function Asteroid () {}
Asteroid.inherits(MovingObject);

MovingObject.prototype.makeNoise = function() {
  console.log("Whoosh!");
};

Asteroid.prototype.explode = function () {
  console.log("I'm exploding!");
};

var testShip = new Ship();
testShip.makeNoise();

var testAsteroid = new Asteroid();
testAsteroid.makeNoise();

var testObject = new MovingObject();
// testObject.explode();
// testShip.explode();
console.log(testShip.constructor); // Ask a TA?