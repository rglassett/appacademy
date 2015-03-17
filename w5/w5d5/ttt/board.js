var Board = function () {
  this.rows = new Array(3);
  for (var i = 0; i < 3; i++) {
    this.rows[i] = new Array(3);
  }
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

Board.prototype.checkCols = function (mark) {
  for (var col = 0; col < 3; col++) {
    if (this.rows[0][col] === mark &&
          this.rows[1][col] === mark &&
          this.rows[2][col] === mark) {
      return true;
    }
  }
  return false;
};

Board.prototype.checkRows = function (mark) {
  for (var row = 0; row < 3; row++) {
    if (this.rows[row][0] === mark &&
          this.rows[row][1] === mark &&
          this.rows[row][2] === mark) {
      return true;
    }
  }
  return false;
};

Board.prototype.checkDiags = function (mark) {
  if ((this.rows[0][0] === mark &&
  this.rows[1][1] === mark &&
  this.rows[2][2] === mark) ||
  
  (this.rows[0][2] === mark &&
   this.rows[1][1] === mark &&
   this.rows[0][2] === mark)) {
    return true;
  }
  return false;
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
  for (var i = 0; i < 3; i++) {
    var rowString = JSON.stringify(this.rows[i]);
    console.log(rowString.replace(/null/g, '   '));
  }
};

module.exports = Board;