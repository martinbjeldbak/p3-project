$(function() {
  $(".favour-button").live('click', function() {
    var button = $(this);
    var action = button.attr('href');
    var adding = action.indexOf('add') !== - 1;
    var $favCount = $('#num_favorites');
    var newFavCount = 0;

    startLoading();
    $.ajax({
      url: action,
      type: "POST",
      dataType: "JSON",
      success: function(json) {
        if (adding) {
          button.addClass('favoured');
          button.attr('title', 'Fjern opskrift fra favoritter');
          button.attr('href', action.replace('add', 'remove'));

          newFavCount = parseInt($favCount.text(), 10) + 1;

          $favCount.text(newFavCount);
        }
        else {
          button.removeClass('favoured');
          button.attr('title', 'Tilføj opskrift til favoritter');
          button.attr('href', action.replace('remove', 'add'));

          newFavCount = parseInt($favCount.text(), 10) - 1;
          $favCount.text(newFavCount);
        }
        stopLoading();
      },
      error: function(error) {
        stopLoading();
        alert("Der skete en ubeskrivelig fejl");
      }
    });
    return false;
  });
});
