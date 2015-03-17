(function () {
  if(typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }
  
  var Util = Asteroids.Util = {
  };

  Util.inherits = function (child, parentConstructor) {
    var Surrogate = function () {};
    Surrogate.prototype = parentConstructor.prototype;
    child.prototype = new Surrogate();
    child.prototype.constructor = child;
  };

  Util.randomVec = function(length) {
    var x = Math.floor((Math.random() - 0.5) * length * 2);
    var y = Math.floor((Math.random() - 0.5) * length * 2);

    return [x, y];
  };
  
  Util.distance = function (pos1, pos2) {
    var x = pos1[0] - pos2[0];
    var y = pos1[1] - pos2[1];
    
    return Math.sqrt((x * x) + (y * y));
  };
})();