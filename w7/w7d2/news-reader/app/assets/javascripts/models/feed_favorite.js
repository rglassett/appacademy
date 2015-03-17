NewsReader.Models.FeedFavorite = Backbone.Model.extend({
  urlRoot: 'api/favorite_feeds/',
  initialize: function (options) {
    this.feed_id = options.feed_id;
  }
  
});