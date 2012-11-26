$(function() {

  var submitButton = $("#search-form .submit-button");
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

  var setupButtons = function() {
    $( ".favour-button" ).button({
      icons: {
        primary: "ui-icon-heart"
      },
      text: false
    });

    $( ".shopping-button" ).button({
      icons: {
        primary: "ui-icon-note"
      },
      text: false
    });
    
    $( ".report-button" ).button({
      icons: {
        primary: "ui-icon-alert"
      },
      text: false
    }).removeClass('ui-button')
      .removeClass('ui-state-default')
      .addClass('ui-dialog-titlebar-close');
  }

  setupButtons();

  submitButton.disable();
  
  $('#search-form').parent().find(">ul").children().each(
	function(index, element){
		addFoodType( $(this).text() );
		var removeButton = $(this).find(">a").listRemoveButton();
        removeButton.click(function() {
          removeFoodType($(this).parent().text());
          $(this).parent().remove();
        });
	}
  );
 
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
        $('#search-form').parent().find(">ul").append(listItem);
      }
      setTimeout(function() {
        $("#ingredient").val("");
        //$("html, body").animate({ scrollTop: $(document).height() }, 1000);
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
  
  var checkboxValue = 0;
  var radioValue = '';

  getNewRecipes = function() {
    var value = '';
    foodTypes.forEach(function(foodType, i) {
      value += foodType + "|";
    });
    $.ajax({
      url: "/search",
      method: "GET",
      data: {q: value, r: checkboxValue, s: radioValue},
      dataType: 'text',
      success: function(data) {
        $("#recipe-result ul").html(data);
        setupButtons();
      },
      error: function(xmlHttpderp, error) {
        alert("nope. " + error);
      }
    });
  };

  $("#sidebar #search-form").submit(function() {
    if ($("#search-form .submit-button").attr('disabled') == 'disabled') {
      return false;
    }
    else {
      getNewRecipes();
      return false;
    }
  });

  $("#sorting input").change(function() {
    if ($(this).is(":checked")) {
      radioValue = $(this).val();
    }
    getNewRecipes();
  });
  
  $("#prep-time input").change(function() {
    if ($(this).is(":checked")) {
      checkboxValue += parseInt($(this).val());
    }
    else {
      checkboxValue -= parseInt($(this).val());
    }
    getNewRecipes();
  });


  $('.welcome form').submit(function() {
    var box = $(this).parent().parent();
    box.animate({opacity: '0'}, 400).slideUp(500, function() {
      var d = new Date();
      d.setTime(d.getTime() + 365 * 24 * 60 * 60 * 1000);
      document.cookie = "welcome=welcome; expires=" + d.toGMTString() + "; path=/";
    });
    return false;
  });

  $('.shopping-button').on("click", function() {
      $(this).hide();

      var $recipeID = $('.shopping-button').data('id');
      var $ingCount = parseInt($('.shopping-button').data('count'));

      var $currentList = $('#num_list_items');
      var $currentListCount = parseInt($currentList.text());

      $currentList.text(($ingCount + $currentListCount), 10);

      $.ajax({
          url: "/list/addrecipe",
          type: "POST",
          data: {id: $recipeID},
          dataType: "json",
          success: function(response) {
          },
          error: function(xhr, error) {
              //alert("Fejl i tilføjelse af ingredienser fra opskrift til indkøblisten.");
              //$(document.body).html(xhr.responseText);
          }
      });
      return false;
  });
});
