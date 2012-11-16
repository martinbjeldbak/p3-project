$(function() {
  $("#ingredient").autocomplete({
    source: function(request, response) {
      $.ajax({
        url: "/search/autocomplete/" + request.term,
        success: function(data) {
          response(data);
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
