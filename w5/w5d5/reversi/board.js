var Board = function () {
  this.rows = new Array(8);
  for (var i = 0; i < 8; i++) {
    this.rows[i] = new Array(8);
  }
};

Board.DELTAS = [
  [0,   1],
  [1,   0],
  [-1,  0],
  [0,  -1],
  [1,   1],
  [-1,  1],
  [1,  -1],
  [-1, -1]];

Board.prototype.isOver = function () {
  for (var i = 0; i < 8; i++) {
    for (var j = 0; j < 8; j++) {
      if (this.isEmpty([i, j])) { return false; }
    }
  }
  return true;
};

Board.prototype.isWon = function () {
  return !!this.winner();
};

Board.prototype.winner = function () {
  var syms = ["X", "O"];
  for (var i = 0; i < syms.length; i++) {
    if(this.checkCols(syms[i]) ||
          this.checkRows(syms[i]) ||
          this.checkDiags(syms[i])) {
      return syms[i];
    }
  }
  return null;
};

Board.prototype.isEmpty = function (pos) {
  return this.rows[pos[0]][pos[1]] === undefined;
};

Board.prototype.placeMark = function (pos, mark) {
  if (this.isEmpty(pos)) {
    this.rows[pos[0]][pos[1]] = mark;
    return true;
  } else {
    return false;
  }
};

Board.prototype.print = function() {
  for (var i = 0; i < 8; i++) {
    var rowString = JSON.stringify(this.rows[i]);
    console.log(rowString.replace(/null/g, '   '));
  }
};

module.exports = Board;