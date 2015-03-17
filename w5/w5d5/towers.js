var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var HanoiGame = function() {
  this.stacks = [[3, 2, 1], [], []];
};

HanoiGame.prototype.isWon = function () {
  if (this.stacks[0].length === 0 &&
    (this.stacks[1].length === 0 || this.stacks[2].length === 0)) {
      return true;
    } else {
      return false;
    }
};

HanoiGame.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
  var startTower = this.stacks[startTowerIdx];
  var endTower = this.stacks[endTowerIdx];
  
  if (startTower.length === 0) {
    return false;
  } else if (endTower.length === 0) {
    return true;
  } else if (startTower[startTower.length - 1] > endTower[endTower.length - 1]) {
    return false;
  } else {
    return true;
  }
};

HanoiGame.prototype.move = function (startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    this.stacks[endTowerIdx].push(this.stacks[startTowerIdx].pop());
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  reader.question("Enter the tower you wish to move from, then tower you wish" +
    " to move to (e.g. '1,2')", function(moves) {
    moves = moves.split(",");
    callback(moves[0], moves[1]);
  });
};

HanoiGame.prototype.run = function (completionCallback) {
  var that = this;
  
  this.promptMove( function (startIdx, endIdx) {
    if (!that.move(startIdx, endIdx)) {
      console.log("FLAGRANT SYSTEM ERROR ABORT ABORT ABORT!!!!");
    }
    if (!that.isWon()) {
      that.run(completionCallback);
    } else {
      console.log('WINNER === YOU');
      completionCallback();
    }
  });
};

var game = new HanoiGame();
game.run( function () {
  reader.close();
});