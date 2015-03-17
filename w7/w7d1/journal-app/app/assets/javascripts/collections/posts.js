window.JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "/posts",
  model: JournalApp.Models.Post,
  
  getOrFetch: function (id) {
    var posts = this;
    var post = posts.get(id);
    if (!post) {
      post = new JournalApp.Models.Post({ id: id });
      // posts.add(post);
      post.fetch({
        success: function () { 
          posts.add(post);
          console.log("success");
        }
      });
    }
    return post;
  }
});

window.JournalApp.Collections.posts = new window.JournalApp.Collections.Posts();