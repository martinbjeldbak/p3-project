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

  var foodTypes = [];

  var updateFoodTypes = function () {
    var value = '';
    foodTypes.forEach(function(foodType, i) {
      value += foodType + "|";
    });
    if (value == '') {
      submitButton.disable();
    }
    else {
      submitButton.enable();
    }
    $('#search-form .food-types').val(value);
  };

  var addFoodType = function(value) {
    if (foodTypes.indexOf(value) > -1) {
      return false;
    }
    foodTypes.push(value);
    updateFoodTypes();
    return true;
  };

  var removeFoodType = function(value) {
    var index = foodTypes.indexOf(value);
    if (index > -1) {
      foodTypes.splice(index, 1);
      updateFoodTypes();
    }
  };

  submitButton.disable();
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
      if (addFoodType(ui.item.value)) {
        var listItem = $('<li />');
        listItem.html(ui.item.value);
        listItem.data('value', ui.item.value);
        var removeButton = $('<a />').attr('href', '#').listRemoveButton();
        removeButton.click(function() {
          removeFoodType($(this).parent().data('value'));
          $(this).parent().remove();
        });
        listItem.append(removeButton);
        $('#search ul').append(listItem);
      }
      setTimeout(function() {
        $("#ingredient").val("");
        $("html, body").animate({ scrollTop: $(document).height() }, 1000);
      }, 50)
    },
  });
  $("#search-form").submit(function() {
    if ($("#search-form .submit-button").attr('disabled') == 'disabled') {
      return false;
    }
    else {
      return true;
    }
  });
});
