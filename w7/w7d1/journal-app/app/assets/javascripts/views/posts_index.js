window.JournalApp.Views.PostsIndex = Backbone.View.extend({
  template: JST["posts_index"],
  
  events: {
    "click button.delete": "destroyPost"
  },
  
  initialize: function () {
    this.listenTo(
      this.collection, 
      "remove add change:title reset sync", 
      this.render
    );
  },
  
  render: function() {
    console.log('rendering the index')
    var renderedContent = this.template({ posts: this.collection });
    this.$el.html(renderedContent);
    return this
  },
  
  destroyPost: function (event) {
    var postId = $(event.currentTarget).data("id");
    this.collection.get(postId).destroy();
  }
});