var TTT = require("./ttt/index.js");

var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var p1 = new TTT.HumanPlayer("Strong Bad");
var p2 = new TTT.ComputerPlayer("Tandy 500");

var game = new TTT.Game(reader, p1, p2);
game.run(function () {
  reader.close();
});