(function () {
  if(typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }
  
  var Asteroid = Asteroids.Asteroid = function(options) {
    options.radius = Asteroid.RADIUS;
    options.color  = Asteroid.COLOR;
    options.vel    = Asteroids.Util.randomVec(5);
    Asteroids.MovingObject.call(this, options);
  };

  Asteroid.COLOR = '#FFFF66';
  Asteroid.RADIUS = 15;  

  Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);
  
  Asteroid.prototype.collideWith = function (otherObject) {
    if (otherObject.constructor === Asteroids.Ship) {
      otherObject.relocate();
    }
  };
  
})();