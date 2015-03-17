(function () {
  if(typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }
  
  var MovingObject = Asteroids.MovingObject = function (options) {
    this.pos = options.pos;
    this.vel = options.vel;
    this.radius = options.radius;
    this.color = options.color;
    this.game = options.game;
  };
  
  MovingObject.prototype.collideWith = function (otherObject) {
    return;
  };
  
  MovingObject.prototype.draw = function (ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();
    var that = this;

    ctx.arc(
      that.pos[0],
      that.pos[1],
      that.radius,
      0,
      2 * Math.PI,
      false
    );
    
    if (this.constructor === Asteroids.Bullet) {
      ctx.fillStyle = this.color;
    } else {
      ctx.fillStyle = "#000000"
    }
    
    ctx.fill();
    ctx.strokeStyle = this.color;
    ctx.lineWidth = 3;
    ctx.stroke();
  };
  
  MovingObject.prototype.isWrappable = true;
  MovingObject.prototype.drag = 0;
  

  MovingObject.prototype.move = function () {
    this.pos = [this.pos[0] + this.vel[0], this.pos[1] + this.vel[1]];
    if (this.isWrappable) {
      this.pos = this.game.wrap(this.pos);
    } else if (this.game.isOutOfBounds(this.pos)) {
      this.game.remove(this);
    }
  };
  
  MovingObject.prototype.test = function (canvasEl) {
    var ctx = canvasEl.getContext("2d");
    window.setInterval((function () {
      this.move();
      this.draw(ctx);
    }).bind(this), 60 / 1000);
  };
  
  MovingObject.prototype.isCollidedWith = function (otherObject) {
    var distance = Asteroids.Util.distance(this.pos, otherObject.pos);
    var radii = this.radius + otherObject.radius;
    if (distance < radii) {
      return true;
    }
    return false;
  };
})();