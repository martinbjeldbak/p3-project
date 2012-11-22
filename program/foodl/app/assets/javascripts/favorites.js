$(function() {
  $(".favour-button").live('click', function() {
    var button = $(this);
    var action = button.attr('href');
    var adding = action.indexOf('add') !== - 1;
    $.ajax({
      url: action,
      type: "POST",
      dataType: "JSON",
      success: function(json) {
        if (adding) {
          button.addClass('favoured');
          button.attr('title', 'Fjern opskrift fra favoritter');
          button.attr('href', action.replace('add', 'remove'));
        }
        else {
          button.removeClass('favoured');
          button.attr('title', 'Tilføj opskrift til favoritter');
          button.attr('href', action.replace('remove', 'add'));
        }
      },
      error: function(error) {
        alert("Der skete en ubeskrivelig fejl");
      }
    });
    return false;
  });
});
