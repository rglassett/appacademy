$.Thumbnails = function (el) {
  this.$el = $(el);
  this.$items = $(".thumbnails").find(".items");
  this.$imgs = this.$items.find("img");

  this.currentIndex = 0;
  this.tempIndex = null;
  this.gutterIndices = [0, 1, 2, 3, 4];
  
  this.buildImageNav();
  this.bindHandlers();
  this.setActiveImage(this.currentIndex);
};

$.Thumbnails.prototype.bindHandlers = function () {
  this.$imageNav.find('.navleft').on("click", function () {
    this.moveGutterStart(-1);
  }.bind(this));
  
  this.$imageNav.find('.navright').on("click", function () {
    this.moveGutterStart(1);
  }.bind(this));
  
  this.$gutter.on('click', 'li', this.setCurrentIndex.bind(this));
  
  this.$gutter.on('mouseover', 'li', this.setTempActive.bind(this));
  this.$gutter.on('mouseleave', 'li', this.removeTempActive.bind(this));
};

$.Thumbnails.prototype.setTempActive = function (event) {
  var $li = $(event.currentTarget);
  this.tempIndex = $li.data("id");
  this.setActiveImage(this.tempIndex);
};

$.Thumbnails.prototype.removeTempActive = function () {
  this.tempIndex = null;
  this.setActiveImage(this.currentIndex);
};




$.Thumbnails.prototype.buildImageNav = function () {
  this.$imageNav = $("<div class='image-nav'></div>");
  this.$el.append(this.$imageNav);
  
  this.$imageNav.append("<a href='#' class='navleft'>&lt;</a>");
  this.$gutter = $("<ul class='gutter'></ul>");
  this.fillGutter();
  this.$imageNav.append(this.$gutter);
  this.$imageNav.append("<a href='#' class='navright'>&gt;</a>");
};


$.Thumbnails.prototype.fillGutter = function () {
  this.$gutter.empty();
  for (var i = 0; i < this.gutterIndices.length; i++) {
    var $li = $('<li></li>');
    $li.data("id", this.gutterIndices[i]);
    $li.append($(this.$imgs[this.gutterIndices[i]]).clone());
    this.$gutter.append($li);
  }
};

$.Thumbnails.prototype.moveGutterStart = function (int) {
  this.setGutterStart(this.gutterIndices[0] + int);
};

$.Thumbnails.prototype.setActiveImage = function (idx) {
  this.$imgs.removeClass("active");
  $(this.$imgs[idx]).addClass("active");
  this.setActiveThumb();
};

$.Thumbnails.prototype.setActiveThumb = function () {
  this.$gutter.children().removeClass("active");
  this.gutterIndices.forEach( function(val, idx) {
    if (val === this.currentIndex ) {
      $(this.$gutter.children()[idx]).addClass("active");
    }
  }.bind(this));
};

$.Thumbnails.prototype.setCurrentIndex = function (event) {
  var $li = $(event.currentTarget);
  this.currentIndex = $li.data("id");
  this.setActiveImage(this.currentIndex);
};

$.Thumbnails.prototype.setGutterStart = function (idx) {
  if (idx >= 0 && idx < this.$imgs.length - 4) {
    this.gutterIndices = [];
    for (var i = idx; i < idx + 5; i ++) {
      this.gutterIndices.push(i);
    }
  }
  this.fillGutter();
};

$.fn.thumbnails = function () {
  return this.each(function () {
    new $.Thumbnails(this);
  });
};