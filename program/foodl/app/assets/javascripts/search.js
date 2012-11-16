$(function() {
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
      setTimeout(function() {
        $("#ingredient").val("");
      }, 50);
    },
  });
});
