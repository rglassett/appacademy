(function () {
  if(typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }
  
  var Ship = Asteroids.Ship = function(options) {
    options.radius = Ship.RADIUS;
    options.color  = Ship.COLOR;
    options.vel    = [0, 0];
    this.facing    = 3 * Math.PI / 2;
    Asteroids.MovingObject.call(this, options);
  };

  Ship.COLOR = '#66FFFF';
  Ship.RADIUS = 10;  

  Asteroids.Util.inherits(Ship, Asteroids.MovingObject);
  
  Ship.prototype.relocate = function () {
    this.pos = this.game.randomPosition();
    this.vel = [0, 0];
  };
  
  // Ship.prototype.power = function (impulse) {
  //   var coeff = 0.2
  //   this.vel[0] += impulse[0] * coeff;
  //   this.vel[1] += impulse[1] * coeff;
  // };
  
  Ship.prototype.radiansToVector = function (radians) {
    var y = Math.sin(radians);
    var x = Math.cos(radians);
    return [x, y];
  }

  Ship.prototype.rotate = function (degree) {
    var coeff = 0.2;
    this.facing += degree * coeff;
  };
  
  Ship.prototype.power = function (thrust) {
    var coeff = 0.1;
    var thrust = 0 || thrust * coeff;
    var facing = this.radiansToVector(this.facing);
    this.vel[0] += facing[0] * thrust;
    this.vel[1] += facing[1] * thrust;
  };
  
  Ship.prototype.fireBullet = function () {
    // var bulletVel = [(this.vel[0] + 1) * 2, (this.vel[1] + 1) * 2];
    var bulletVel = this.radiansToVector(this.facing);
    bulletVel[0] += this.vel[0];
    bulletVel[1] += this.vel[1];
    options = { pos: this.pos, vel: bulletVel, game: this.game };
    this.game.add(new Asteroids.Bullet(options));
  };
})();