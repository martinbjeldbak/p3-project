$(function() {

  var submitButton = $("#search-form .submit-button");
  submitButton.enable = function() {
    this.removeAttr('disabled');
    this.removeClass('ui-state-hover');
    this.removeClass('ui-state-active');
    this.button('enable');
  };
  submitButton.disable = function() {
    this.attr('disabled', 'disabled');
    this.removeClass('ui-state-hover');
    this.removeClass('ui-state-active');
    this.button('disable');
  };
  submitButton.disable();
  $('#search ul li a').listRemoveButton();
  $("#ingredient").data('rIndex', 0);
  $("#ingredient").autocomplete({
    source: function(request, response) {
      $("#ingredient").data('rIndex', $("#ingredient").data('rIndex') + 1);
      if (this.xhr) {
        this.xhr.abort();
      }
      this.xhr = $.ajax({
        url: "/search/autocomplete/" + request.term,
        context: {
          autocompleteRequest: $("ingredient").data('rIndex')
        },
        success: function(data) {
          if (this.autocompleteRequest === $("ingredient").data('rIndex')) {
            response(data);
          }
        },
      });
    },
    appendTo: '#menu-container',
    autoFocus: true,
    select: function(e, ui) {
      alert(ui.item.value + " selected!");
      submitButton.enable();
      setTimeout(function() {
        $("#ingredient").val("");
      }, 50)
    },
  });
  $("#search-form").submit(function() {
    if ($("#search-form input[name=food_types]").val() == "") {
      submitButton.disable();
      return false;
    }
  });
});
