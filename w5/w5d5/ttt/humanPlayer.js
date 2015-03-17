var HumanPlayer = function (name) {
  this.name = name;
};

HumanPlayer.prototype.move = function (reader, board, callback) {
  reader.question("Enter the coordinates where you want to move" + 
  " (e.g. 'row,col')", function(pos) {
    pos = pos.split(",");
    pos = pos.map(Number);
    callback(pos);
  });
};

module.exports = HumanPlayer;