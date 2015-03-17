NewsReader.Views.EntryIndex = Backbone.View.extend({
  initialize: function (options) {
    this.collection = options.collection;
  },
  
  template: JST["entry_index"],
  
  tagName: 'ul',

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);
    var index = this;
    this.collection.each(function (entry) {
      var view = new NewsReader.Views.EntryShow({ model: entry });
      index.$el.append(view.render().$el);
    })
    return this;
  },
});