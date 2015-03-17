$.Carousel = function (el) {
  this.$el = $(el);
  this.$items = $(".carousel").find(".items");
  this.$imgs = this.$items.find("img");
  this.activeIndex = 0;
  this.transitioning = false;
  
  $(this.$imgs[this.activeIndex]).addClass("active");
  
  this.$previous = this.$el.find(".slide-left");
  this.$next = this.$el.find(".slide-right");
  
  this.$previous.on("click", this.slideLeft.bind(this));
  this.$next.on("click", this.slideRight.bind(this));
};

$.Carousel.prototype.slide = function (int) {
  if (this.transitioning) {
    return;
  }
  
  this.transitioning = true;
  
  var slideDir = (int > 0 ? "right" : "left");
  var slideOpp = (slideDir === "right" ? "left" : "right");
  
  var $oldItem = $(this.$imgs[this.activeIndex]);
  this.shiftIndex(int);
  var $newItem = $(this.$imgs[this.activeIndex]);

  $newItem.addClass("active " + slideDir);
  // $oldItem.addClass(slideOpp);
  
  setTimeout(function () {
    $newItem.removeClass("left right");
    $oldItem.addClass(slideOpp);
  }, 0);
  
  $oldItem.one("transitionend", function () {
    $oldItem.removeClass("active left right");
    this.transitioning = false;
  }.bind(this));
};

$.Carousel.prototype.shiftIndex = function (int) {
  var newIndex = this.activeIndex + int;
  
  if (newIndex < 0) {
    newIndex = this.$imgs.length - 1;
  } else if (newIndex >= this.$imgs.length) {
    newIndex = 0;
  }
  
  this.activeIndex = newIndex;
};

$.Carousel.prototype.slideLeft = function () {
  this.slide(-1);
};

$.Carousel.prototype.slideRight = function () {
  this.slide(1);
};

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};