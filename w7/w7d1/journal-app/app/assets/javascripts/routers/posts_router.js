window.JournalApp.Routers.PostsRouter = Backbone.Router.extend({
  
  routes: {
    "": "postIndex",
    "posts/new": "postForm",
    "posts/:id": "postShow"
  },
  
  initialize: function (options) {
    this.$content = options.content;
    this.$sidebar = options.sidebar;
    this.postIndex();
  },
  
  postIndex: function() {
    var view = new JournalApp.Views.PostsIndex({
      collection: JournalApp.Collections.posts
    });
    window.JournalApp.Collections.posts.fetch({
      success: function(){
        this.$sidebar.html(view.render().$el);
      }.bind(this)
    });
  },
  
  postShow: function(id) {
    var model = JournalApp.Collections.posts.getOrFetch(id);
    var view = new JournalApp.Views.PostShow({
      model: model
    });
    this.$content.html(view.render().$el);
  },
  
  postForm: function () {
    var model = new JournalApp.Models.Post();
    var view = new JournalApp.Views.PostForm({
      model: model
    });
    this.$content.html(view.render({ post: model, errors: [] }).$el);
  }
  
})