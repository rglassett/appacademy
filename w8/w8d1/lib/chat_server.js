var chatServer = function (server) {
  var io = require('socket.io')(server);
  var guestnumber = 1;
  var nicknames = {}; // keys are sockets, values are usernames
  var currentRooms = {};
  var roomList = {};
  
  var validNick = function (nick) {
    var isValid = true;
    
    if (!!nick.match(/^guest\d*$/i)) { // Working! yayayyyyyy!
      isValid = false;
    }
  
    Object.keys(nicknames).forEach(function (key) {
      if (nicknames[key] === nick) {
        isValid = false;
      }
    });
    
    return isValid;
  };

  io.on('connection', function (socket) {
    nicknames[socket.id] = 'guest' + guestnumber;
    
    socket.join('Lobby');
    
    currentRooms[socket.id] = 'Lobby';
    guestnumber += 1;
    emitRoomList();
    
    io.to(currentRooms[socket.id]).emit('message', {
      nick: 'Server',
      text: nicknames[socket.id] + ' has joined the channel.'
    });
    
    socket.on('disconnect', function () {
      io.to(currentRooms[socket.id]).emit('message', {
        text: nicknames[socket.id] + ' has left the channel.'
      });
      delete nicknames[socket.id];
      delete currentRooms[socket.id];
      emitRoomList();
    });
    
    socket.on('message', function (data) {
      data.nick = nicknames[socket.id];
      io.to(currentRooms[socket.id]).emit('message', data);
    });
    
    socket.on('nicknameChangeRequest', function (data) {
      changeNick(data.nick);
    });
    
    socket.on('roomChangeRequest', function (data) {
      handleRoomChangeRequests(data.newRoom);
    });
    
    function handleRoomChangeRequests (newRoom) {
      socket.leave(currentRooms[socket.id]);
      currentRooms[socket.id] = newRoom;
      socket.join(newRoom);
      emitRoomList();
    }
    
    function changeNick (newNick) {

      if (validNick(newNick)) {
        var oldNick = nicknames[socket.id];
        nicknames[socket.id] = newNick;
        emitRoomList();
        
        io.to(currentRooms[socket.id]).emit("message", {
          nick: 'Server',
          text: oldNick + ' has changed their name to ' + newNick
        });

      } else {
        socket.emit('message', {
          nick: "Server",
          text: "Nickname is invalid or already taken."
        });
      }
    }
    
    function emitRoomList () {
      buildRoomList();
      io.emit('roomList', { roomList: roomList });
    }
    
    function buildRoomList () {
      roomList = {};
      
      Object.keys(currentRooms).forEach(function (socketId) {
        console.log(socketId + ": " + currentRooms[socketId]);
        var room = currentRooms[socketId];
        var nickname = nicknames[socketId];
        roomList[room] = roomList[room] || [];
        roomList[room].push(nickname);
      });
    }
  });  
};

module.exports = chatServer;