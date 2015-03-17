// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap

$(function () {
  $('.dummy-form').on('submit', function (event) {
    event.preventDefault();
    $('.alert').remove();
    $(':input').removeClass('has-warning has-error has-success');
    
    var anyErrors = false;
    $(event.currentTarget).find('.form-control').each(function (index, el) {
      var $el = $(el);
      if ($el.val().length === 0) {
        $el.parent().addClass("has-error");
        anyErrors = true;
      } else {
        $el.parent().addClass("has-success");
      }
    });
    
    var $alertEl = $('<div></div>');
    
    if (anyErrors) {
      $alertEl.addClass("alert-danger");
      $alertEl.text("Failed submission!");
    } else {
      $alertEl.addClass("alert-success");
      $alertEl.text("Successful submission!");
    }
    
    $('body').append($alertEl);
  });
  
  $(".tooltipped").tooltip();
});