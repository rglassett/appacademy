(function () {
  if (typeof App === 'undefined') {
    window.App = {};
  }
  
  var ChatUi = window.App.ChatUi = function (options) {
    this.chat = options.chat;
    this.$rootEl = options.$rootEl;
  };
  
  ChatUi.prototype.roomList = function (roomList) {
    this.$rootEl.find('.rooms').empty();
    var that = this;
    
    Object.keys(roomList).forEach(function (room) {
      var $header = $('<h3></h3>');
      $header.text(room);
      that.$rootEl.find('.rooms').append($header);
      
      var $uList = $('<ul></ul>');
      roomList[room].forEach(function (user) {
        var $li = $('<li></li>');
        $li.text(user);
        $uList.append($li);
      });
      
      that.$rootEl.find('.rooms').append($uList);
    });
  };

  ChatUi.prototype.getMessage = function () {
    var message = this.$rootEl.find('#msg').val();
    this.$rootEl.find('#msg').val('');
    return message;
  };

  ChatUi.prototype.sendMessage = function () {
    var input = this.getMessage();
    this.chat.processCommand(input);
  };

  ChatUi.prototype.addMessage = function (message) {
    var $ul = this.$rootEl.find('#msgs');
    var $li = $('<li></li>');
    $li.text(message);
    $ul.append($li);
  };
})();

$(function () {
   var socket = io('http://localhost');
   var chat = new App.Chat(socket);
   var ui = new App.ChatUi({
     chat: chat,
     $rootEl: $('body')
   });
  
  socket.on('roomList', function (data) {
    ui.roomList(data.roomList);
  });
   
  socket.on('message', function (data) {
    var message = '< ' + data.nick + ' > ' + data.text;
    ui.addMessage(message);
  });
  
  $('form').on('submit', function (event) {
    event.preventDefault();
    ui.sendMessage();
  })
});