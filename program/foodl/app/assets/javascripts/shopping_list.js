/* Place all the behaviors and hooks related to the matching controller here.
 All this logic will automatically be available in application.js.
 You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/ */

$(function() {
    var submitButton = $('#submitButton');
    $(submitButton).disable();

    // Add remove button to links
    $('#list li a').listRemoveButton();

    // Upon clicking on the remove button
    $('#list').on("click", "li a", function(event){
        var listItem = this;

        $(this).children().hide();
        $(this).hide();

        $.ajax({
            url: "/list/remove",
            type: "POST",
            data: {id: $(this).parent().data("id") },
            dataType: "JSON",
            success: function(json) {
                $(listItem).parent().next().remove();
                $(listItem).parent().remove();
            },
            error: function(xhr, err) {
                if(xhr.status == 500) {
                    $(document.body).html(xhr.responseText);
                }
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

    // Upon submitting to the form, go through the controller
    $('#addListItemForm').submit(function() {
        var name = $('input#list_item_name').val();

        if(name < 1) {
          return false;
        }

        $.ajax({
            url: $(this).attr('action'),
            type: "POST",
            data: {name: name},
            dataType: "JSON",
            success: function(responseItem) {
                var listItem = $('<li />');
                listItem.data("id", responseItem.id);
                listItem.html(name);
                listItem.append($('<a href="#"></a>').listRemoveButton());

                $('#list ul').append(listItem);
                listItem.after('<div class="blue_line_horisontal"></div>');

                $('#list_item_name').val(' ');
            },
            error: function(xhr, error) {
                //alert("readyState: "+xhr.readyState+"\nstatus: "+xhr.status);

                if(xhr.status == 500) {
                    $(document.body).html(xhr.responseText);
                }
                //alert("Fejl på siden! Kunne ikke tilføje tekststreng: " + error.message + ".");
            }
        });
        return false;
    });
});