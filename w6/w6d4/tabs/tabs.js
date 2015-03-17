$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.data("contentTabs")).children();
  this.$links = $(this.$el.find('a'));
  this.$el.on('click', 'a', this.clickTab.bind(this));
};

$.Tabs.prototype.clickTab = function (event) {
  if (this.transitioning) {
    return;
  }
  
  this.transitioning = true;
  event.preventDefault();
  
  var $activeTab = $(this.$contentTabs.filter('.active'));
  
  $activeTab.addClass("transitioning");
  $activeTab.removeClass("active");
  
  var $targetLink = $(event.currentTarget);
  var $targetTab = this.$contentTabs.filter($targetLink.attr("href"));
  
  $activeTab.one("transitionend", function () {
    $activeTab.removeClass("transitioning");
    $targetTab.addClass("transitioning");
    setTimeout(function () {
      $targetTab.removeClass("transitioning");
      $targetTab.addClass("active");
      this.transitioning = false;
    }.bind(this), 0);
  }.bind(this));
  
  this.$links.removeClass('active');
  $targetLink.addClass('active');
  
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};