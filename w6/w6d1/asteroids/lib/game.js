(function () {
  if(typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }
  
  var Game = Asteroids.Game = function () {
    this.asteroids = [];
    this.bullets = [];
    this.addAsteroids();
    this.ship = new Asteroids.Ship({ pos: this.randomPosition(), game: this });
  };
  
  Game.prototype.DIM_X = window.innerWidth;
  Game.prototype.DIM_Y = window.innerHeight;
  Game.prototype.NUM_ASTEROIDS = 0;
  
  Game.prototype.randomPosition = function () {
    var x = Math.floor(Math.random() * this.DIM_X);
    var y = Math.floor(Math.random() * this.DIM_Y);
    return [x, y];
  };
  
  Game.prototype.addAsteroids = function () {
    for (var i = 0; i < this.NUM_ASTEROIDS; i++) {
      var obj = {
        pos: Game.prototype.randomPosition(),
        game: this
      };
      this.add(new Asteroids.Asteroid(obj));
    }
  };
  
  Game.prototype.add = function (obj) {
    if (obj.constructor === Asteroids.Asteroid) {
      this.asteroids.push(obj);
    } else if (obj.constructor === Asteroids.Bullet) {
      this.bullets.push(obj);
    }
  };
  
  Game.prototype.allObjects = function () {
    return this.bullets.concat(this.asteroids.concat(this.ship));
  };
  
  Game.prototype.checkCollisions = function () {
    var that = this;
    that.allObjects().forEach(function (object1) {
      that.allObjects().forEach(function (object2) {
        if (object1 !== object2 && object1.isCollidedWith(object2)) {
          object1.collideWith(object2);
          // alert("COLLISION");
        }
      });
    });
  };
  
  Game.prototype.drawObjects = function (ctx) {
    ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
    ctx.fillStyle = "black";
    ctx.fillRect(0, 0, this.DIM_X, this.DIM_Y);

    this.allObjects().forEach(function (object) {
      object.draw(ctx);
    });
  };
  
  Game.prototype.isOutOfBounds = function (pos) {
    return pos[0] > this.DIM_X ||
    pos[1] > this.DIM_Y ||
    pos[0] < 0 || pos[1] < 0;
  };
  
  Game.prototype.moveObjects = function () {
    this.allObjects().forEach(function (object) {
      object.move();
    });
  };
  
  Game.prototype.remove = function (object) {
    if (object.constructor === Asteroids.Asteroid) {
      var idx = this.asteroids.indexOf(object);
      this.asteroids.splice(idx, 1);
    } else if (object.constructor === Asteroids.Bullet) {
      var idx = this.bullets.indexOf(object);
      this.bullets.splice(idx, 1);
    }

  };
  
  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  };
  
  Game.prototype.wrap = function (pos) {
    var x = (pos[0] + this.DIM_X) % this.DIM_X;
    var y = (pos[1] + this.DIM_Y) % this.DIM_Y;
    
    return [x, y];
  };
  
})();