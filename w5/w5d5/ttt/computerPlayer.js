var ComputerPlayer = function (name) {
  this.name = name;
};

ComputerPlayer.prototype.move = function (reader, board, callback) {
  var x = 0;
  var y = 0;
  do {
    x = Math.floor((Math.random() * 3));
    y = Math.floor((Math.random() * 3));
  } while (!board.isEmpty([x, y]));
  callback([x, y]);
};

module.exports = ComputerPlayer;