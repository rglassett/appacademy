// this.$el.offset() = position of div's top left corner
// event.pageX/pageX = position of mouse on document
// event.pageX - this.$el.offset.left
// event.pageY - this.$el.offset.top

$.Zoomable = function (el) {
  this.$el = $(el);
  this.$img = this.$el.find('img');
  this.focusBoxSize = 60;
  this.hasFocusBox = false;
  this.setImageSize();
  this.bindEvents();
};

$.Zoomable.prototype.bindEvents = function () {
  // this.$el.on('mouseover', this.showFocusBox.bind(this));
  this.$el.on('mouseover', console.log("Hello!"));
  this.$el.on('mouseleave', function () {
    this.removeFocusBox();
    this.removeZoom();
  }.bind(this));
};

$.Zoomable.prototype.setImageSize = function () {
  var img = this.$img[0];
  var picRealHeight;
  var picRealWidth;
  
  $("<img/>")
      .attr("src", $(img).attr("src"))
      .load(function() {
          picRealWidth = this.width;
          picRealHeight = this.height;
      });
  
  this.imageHeight = picRealHeight;
  this.imageWidth = picRealWidth;
};


$.Zoomable.prototype.showFocusBox = function (event) {
  if (!this.hasFocusBox) {
    this.$focusBox = $('<div class="focus-box"></div>');
    this.$el.append(this.$focusBox);
    this.$focusBox.css("height", this.focusBoxSize);
    this.$focusBox.css("width", this.focusBoxSize);
    this.hasFocusBox = true;
  }
  
  this.$el.on("mousemove", function (event) {
    var left = event.pageX - 
              this.$el.offset().left - 
              Math.floor(this.focusBoxSize / 2);
    var up = event.pageY - 
              this.$el.offset().top -
              Math.floor(this.focusBoxSize / 2);
  
    this.$focusBox.css("left", left);
    this.$focusBox.css("top", up);
    this.showZoom(left, up);
  }.bind(this));

};

$.Zoomable.prototype.showZoom = function (xdiff, ydiff) {
  if (!this.hasZoom) {
    this.hasZoom = true;
  
    this.$zoomedImage = $('<div class="zoomed-image"></div>');
    $('body').append(this.$zoomedImage);
    this.$zoomedImage.css("width", $(window).height());
    this.$zoomedImage.css("background-image", this.$img.attr("src"));
  }
  
  var scale = $(window).height() / this.imageHeight;
  var xPos = xdiff * scale;
  var yPos = ydiff * scale;
  
  scale = scale * 100;
  this.$zoomedImage.css("background-size", scale + "%");
  this.$zoomedImage.css("background-position", xPos + " " + yPos)
}

$.Zoomable.prototype.removeZoom = function () {
  this.$zoomedImage.remove();
  this.hasZoom = false;
}

$.Zoomable.prototype.removeFocusBox = function (event) {
  this.$focusBox.remove();
  this.hasFocusBox = false;
};

$.fn.zoomable = function () {
  return this.each(function () {
    new $.Zoomable(this);
  });
};