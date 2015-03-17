window.JournalApp.Views.PostShow = Backbone.View.extend({
  template: JST["post_show"],
  
  events: {
    "dblclick .editable" : "edit",
    "blur .updatable" : "save"
  },
  
  render: function () {
    var content = this.template({ post: this.model })
    this.$el.html(content);
    return this;
  },
  initialize: function () {
    this.listenTo(
      this.model,
      "sync",
      this.render
    )
  },
  
  edit: function(event) {
    this.oldContent = $(event.currentTarget);
    var oldText = this.oldContent.text();
    $(event.currentTarget).html(
    "<input type='text'"+ 
          "class='updatable'" +  
          "data-key='" + this.oldContent.data("key")+"' "+
          "value='" + oldText + "'>"
    );
    $("input").focus();
  },
  
  save: function(event) {
    var savedText = $(event.currentTarget).val();
    var title = $(event.currentTarget).data("key");
    // this.model.set(title, savedText);
    this.model.set(title, savedText);
    var collection = this.model.collection;
    this.model.save({},{
      success: function() {
        console.log("success");
      }
    });
    this.oldContent.text(savedText);
  }
  
});