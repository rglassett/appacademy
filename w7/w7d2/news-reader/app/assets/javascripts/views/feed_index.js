NewsReader.Views.FeedIndex = Backbone.View.extend({
  template: JST["feed_index"],
  initialize: function (options) {
    this.listenTo(this.collection, "sync destroy add", this.render);
  },
  
  events: {
    "click button.delete-feed": "deleteFeed",
    "submit form": "createFeed"
  },
  
  render: function () {
    var renderedContent = this.template( { feeds: this.collection } )
    this.$el.html(renderedContent);
    return this;
  },
  
  createFeed: function (event) {
    event.preventDefault();
    var formVals = $(event.currentTarget).serializeJSON();
    var newFeed = new NewsReader.Models.Feed(formVals['feed']);
    newFeed.save();
    this.collection.fetch();
  },
  
  deleteFeed: function (event) {
    var feeds = NewsReader.Collections.feeds;
    // debugger;
    var feed = feeds.get($(event.currentTarget).data("id"));
    feed.destroy();
  }
});