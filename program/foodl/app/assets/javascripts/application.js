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
//  see https://github.com/joliss/jquery-ui-rails for modules
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.core
//= require jquery.ui.widget
//= require jquery.ui.mouse
//= require jquery.ui.position
//= require jquery.ui.button
//= require jquery.ui.autocomplete
//= require jquery.ui.slider
//= require_tree .

jQuery.fn.listRemoveButton = function() {
  this.button({
    icons: {
      primary: "ui-icon-close"
    },
    text: false
  }).removeClass('ui-button')
    .removeClass('ui-state-default')
    .addClass('ui-dialog-titlebar-close')
    .addClass('list-remove');
  return this;
};

jQuery.fn.enable = function() {
    this.removeProp('disabled');
    this.removeClass('ui-state-hover');
    this.removeClass('ui-state-active');
    this.button('enable');
};
jQuery.fn.disable = function() {
    this.prop('disabled', 'disabled');
    this.removeClass('ui-state-hover');
    this.removeClass('ui-state-active');
    this.button('disable');
};

var startLoading = function() {
  $("#loading").fadeIn(300);
};

var stopLoading = function() {
  $("#loading").fadeOut(300);
};

var messageQueue = [];

var flashMessageFromQueue = function() {
  if (messageQueue.length == 0) {
    return;
  }
  var message = messageQueue[0];
  $("#notification").html(message.message)
    .removeClass()
    .addClass(message.type)
    .fadeIn(300, function() {
      setTimeout(function() {
        $("#notification").fadeOut(300, function() {
          setTimeout(function() {
            messageQueue.shift();
            flashMessageFromQueue();
          }, 50);
        });
      }, message.duration);
    });
};

/**
 * Flash a message to the user
 * @param string message The message
 * @param string type Either "success"(default) or "error"
 * @param integer duration Duration in ms (default=5000)
 */
var flashMessage = function(message, type, duration) {
  if (!duration) {
    duration = 5000;
  }
  if (!type) {
    type = "success";
  }
  if (messageQueue.length == 0) {
    messageQueue.push({message: message, type: type, duration: duration});
    flashMessageFromQueue();
  }
  else {
    messageQueue.push({message: message, type: type, duration: duration});
  }
};


$(function() {
  $('.button').button();
  $('input, textarea').placeholder();
});
