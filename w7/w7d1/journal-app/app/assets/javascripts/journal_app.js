window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var content = $('.content');
    var sidebar = $('.sidebar');
    new window.JournalApp.Routers.PostsRouter({
      content: content,
      sidebar: sidebar
    });
    Backbone.history.start();
    
  }
};

$(document).ready(function(){
  JournalApp.initialize();
});
