(function () {
  if(typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }
  
  var GameView = Asteroids.GameView = function (game, canvasEl) {
    canvasEl.height = window.innerHeight - 25;
    canvasEl.width = window.innerWidth - 25;
    var ctx = canvasEl.getContext("2d");
    this.game = game;
    this.ctx = ctx;
  };
  
  GameView.prototype.start = function () {
    this.bindShootHandler();
    setInterval(function () {
      this.bindMoveHandlers();
      this.game.step();
      this.game.drawObjects(this.ctx);
    }.bind(this), 20);
    
  };
  
  GameView.prototype.bindMoveHandlers = function () {
    var ship = this.game.ship;
    if(key.isPressed('left')) ship.rotate(-1);
    if(key.isPressed('right')) ship.rotate(1);
    if(key.isPressed('down')) ship.power(1);
    if(key.isPressed('up')) ship.power(-1);
  };
  
  GameView.prototype.bindShootHandler = function () {
    var ship = this.game.ship;
    key('space', function(){ship.fireBullet() });
  };
})();