NewsReader.Collections.Entries = Backbone.Collection.extend({
  model: NewsReader.Models.Entry,
  initialize: function (options) {
    this.feed = options.feed;
  },

  comparator: function(foo) {
      // order by 'created_at' DESC
    return -(new Date(foo.get('created_at'))).getTime();
  },
  
  // comparator: function(model1, model2) {
  //   debugger;
  //   if (model1.get("created_at") === model2.get("created_at")) {
  //     return 0;
  //   } else if (model1.get("created_at") > model2.get("created_at")) {
  //     return -1;
  //   } else {
  //     return 1;
  //   }
  // },
  
  url: function () {
    return "feeds/" + this.feed.get('id') + "/entries";
  }
});