(function () {
  if(typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }
  
  var Bullet = Asteroids.Bullet = function(options) {
    options.radius = Bullet.RADIUS;
    options.color  = Bullet.COLOR;
    Asteroids.MovingObject.call(this, options);
  };

  Bullet.COLOR = '#FFFFFF';
  Bullet.RADIUS = 5;  

  Asteroids.Util.inherits(Bullet, Asteroids.MovingObject);
  
  Bullet.prototype.collideWith = function (otherObject) {
    if (otherObject.constructor === Asteroids.Asteroid) {
      otherObject.game.remove(otherObject);
      this.game.remove(this);
    } 
  };
  
  Bullet.prototype.isWrappable = false
})();