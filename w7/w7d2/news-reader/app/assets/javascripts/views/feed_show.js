NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST["feed_show"],
  
  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.entries(), "sync", this.render);
    this.feed = options['feed'];
  },
  
  events: {
    "click .refresh": "refreshFeed",
    "click .favorite": "toggleFeedFavorite"
  },

  render: function () {
    var renderedContent = this.template( { 
      entries: this.model.entries(),
      feed: this.model
    });
    this.$el.html(renderedContent);
    var view = new NewsReader.Views.EntryIndex({ collection: this.model.entries() })
    this.$el.append(view.render().$el);
    return this;
  },
  
  refreshFeed: function (event) {
    this.model.fetch();
    this.render();
  },
  
  toggleFeedFavorite: function (event) {
    var favoriteFeed = new NewsReader.Models.FeedFavorite({
      feed_id: $(event.currentTarget).data("feed-id")
    })
    if ($(event.currentTarget).data("active")) {
      favoriteFeed.save();
      $(event.currentTarget).data("active", "false");
      $(event.currentTarget).text("Unfollow!");
    } else {
      favoriteFeed.destroy();
      $(event.currentTarget).data("active", "true");
      $(event.currentTarget).text("Follow!");
    }
  }
  
});