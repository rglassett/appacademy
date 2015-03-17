NewsReader.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.rootEl;
  },
  routes: {
    '': 'feedsIndex',
    'feeds/:id': 'feedShow',
    'feed_favorites': 'favoriteCreate',
    'feed_favorites/:id': 'favoriteDestroy'
  },
  
  feedsIndex: function () {
    var feeds = NewsReader.Collections.feeds;
    feeds.fetch();
    
    var indexView = new NewsReader.Views.FeedIndex({ collection: feeds });
    this._swapView(indexView);
  },
  
  feedShow: function (id) {
    var feed = NewsReader.Collections.feeds.getOrFetch(id);
    if (feed.entries.length === 0) {
      feed.fetch();      
    }
    var showView = new NewsReader.Views.FeedShow({
      model: feed
    });
    this._swapView(showView);
  },
  
  _swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.html(newView.render().$el);
  }
});