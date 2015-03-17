var Board = require("./board");

var Game = function (reader, player1, player2) {
  this.board = new Board();
  this.player1 = player1;
  this.player2 = player2;
  this.player1.mark = 'X';
  this.player2.mark = 'O';
  this.currentPlayer = this.player1;
  this.reader = reader;
};

Game.prototype.nextTurn = function () {
  this.currentPlayer = (this.currentPlayer === this.player1 ? 
    this.player2 : this.player1);
};

Game.prototype.run = function (completionCallback) {
  var that = this;
  
  this.promptMove( function (pos) {
    if (!that.board.placeMark(pos, that.currentPlayer.mark)) {
      console.log("FLAGRANT SYSTEM ERROR ABORT ABORT ABORT!!!!");
    }
    if (!that.board.isWon()) {
      that.nextTurn();
      that.run(completionCallback);
    } else {
      console.log('WINNER === ' + that.currentPlayer.name);
      completionCallback();
    }
  });
};

Game.prototype.promptMove = function (callback) {
  this.board.print();
  console.log("It is now " + this.currentPlayer.name + "'s turn.");
  this.currentPlayer.move(this.reader, this.board, callback);
};

module.exports = Game;