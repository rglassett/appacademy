window.JournalApp.Views.PostForm = Backbone.View.extend({
  template: JST["post_form"],
  
  events: {
    "submit .post_form": "createPost"
  },
  
  createPost: function (event) {
    event.preventDefault(); 
    var view = this;
    var form = $(event.currentTarget);
    var model = new JournalApp.Models.Post(form.serializeJSON());
    model.save({}, {
      success: function (response) {
        Backbone.history.navigate("#/", {trigger: false});
      }, 
      error: function (response, errors) {
        var post = response.attributes.post;
        var errors = errors.responseJSON || [];
        view.render({post: post, errors: errors});
      }
    });
  },
  
  render: function (options) {
    var view = this;
    var post = options.post || new JournalApp.Models.Post();
    var errors = options.errors || [];
    var renderedContent = view.template({
      post: post,
      errors: errors
    });
    this.$el.html(renderedContent);
    return this
  }
  
});