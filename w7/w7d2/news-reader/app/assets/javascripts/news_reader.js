window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(){
    new NewsReader.Router({
      rootEl: $('.content')
    });
    Backbone.history.start();
   }
 },
  
$(document).ready(function(){
  NewsReader.initialize();
});