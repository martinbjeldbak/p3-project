/* Place all the behaviors and hooks related to the matching controller here.
 All this logic will automatically be available in application.js.
 You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/ */

$(function() {
    var $currentList = $('#num_list_items');
    var submitButton = $('#submitButton');
    $(submitButton).disable();

    // Add remove button to links
    $('#list li a').listRemoveButton();

    // Upon clicking on the remove button
    $('#list').on("click", "li a", function(event){
        var listItem = this;

        $(this).children().hide();
        $(this).hide();

        startLoading();
        $.ajax({
            url: "/list/remove",
            type: "POST",
            data: {id: $(this).parent().data("id") },
            dataType: "JSON",
            success: function(json) {
              $(listItem).parent().next().remove();
              $(listItem).parent().remove();

              var $currentListCount = parseInt($currentList.text(), 10);
              $currentList.text($currentListCount - 1);
              stopLoading();
            },
            error: function(xhr, err) {
             //if(xhr.status == 500) {
             //    $(document.body).html(xhr.responseText);
             //}
              flashMessage("Der skette en fejl på siden. Prøv igen senere.", "error");
              stopLoading();
            }
        });
        return false;
    });

    $('.delete_all_listitems_button').on("click", function() {
        var dataIDs = [];
        var $list = $('ul');

       // $list.slideUp();

        $('ul li').each(function() {
          $(this).next().fadeOut(300);
          $(this).slideUp(300, function() {
            $(this).next().remove();
            $(this).remove();
          });
          dataIDs.push($(this).data('id'));
        });

        startLoading();
        $.ajax({
            url: "/list/deletelist",
            type: "POST",
            data: {ids: dataIDs},
            dataType: "JSON",
            success: function(responseItem) {
                $currentList.text(0);
                stopLoading();
            },
            error: function(xhr, error) {
              $currentList.text(0);
              flashMessage("Der skette en fejl på siden. Prøv igen senere.", "error");
                //if(xhr.status == 500) {
                //    $(document.body).html(xhr.responseText);
            //  }
              stopLoading();
            }
        });
        return false;
    });

    // When the user types in the list item add box for the form
    $('#list_item_name').keyup(function() {

        if($('#list_item_name').val().length == 0) {
            $(submitButton).disable();
        } else {
            $(submitButton).enable();
        }
    });

    // When adding new list items through the form
    $('#addListItemForm').submit(function() {
        var name = $('input#list_item_name').val();

        if(name < 1) {
          return false;
        }

        startLoading();
        $.ajax({
            url: $(this).attr('action'),
            type: "POST",
            data: {name: name},
            dataType: "JSON",
            success: function(responseItem) {
                var listItem = $('<li />');
                listItem.data("id", responseItem.id);
                listItem.html("<div>" + name + "</div>");
                listItem.append($('<a href="#"></a>').listRemoveButton());

                $('#list ul').append(listItem);
                listItem.after('<div class="blue_line_horisontal"></div>');

                $('#list_item_name').val(' ');

                var $currentListCount = parseInt($currentList.text(), 10);
                $currentList.text($currentListCount + 1);
                if ($("#login-reminder").css('display') == 'none') {
                  $("#login-reminder").fadeIn(300);
                }
                stopLoading();
            },
            error: function(xhr, error) {
                //alert("readyState: "+xhr.readyState+"\nstatus: "+xhr.status);

               // if(xhr.status == 500) {
               //     $(document.body).html(xhr.responseText);
               // }
                flashMessage("Der skette en fejl på siden. Prøv igen senere.", "error");
                stopLoading();
                //alert("Fejl på siden! Kunne ikke tilføje tekststreng: " + error.message + ".");
            }
        });
        return false;
    });
});
