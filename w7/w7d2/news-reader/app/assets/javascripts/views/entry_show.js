NewsReader.Views.EntryShow = Backbone.View.extend({
  initialize: function (options) {
    this.model = options.model;
  },
  
  template: JST["entry_show"],
  
  tagName: 'li',

  render: function () {
      // debugger;
    var renderedContent = this.template( { 
      entry: this.model
    });
    this.$el.html(renderedContent);
    return this;
  },
});