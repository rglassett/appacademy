NewsReader.Collections.Feeds = Backbone.Collection.extend({
  model: NewsReader.Models.Feed,
  url: "api/feeds",
  getOrFetch: function (id) {
    var feeds = this;
    var feed = this.get(id);
    if (!feed) {
      feed = new NewsReader.Models.Feed({ id: id });
      feed.fetch({
        success: function () { feeds.add(feed); }
      });
    }
    return feed;
  }
});

NewsReader.Collections.feeds = new NewsReader.Collections.Feeds();