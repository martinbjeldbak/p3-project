/* Place all the behaviors and hooks related to the matching controller here.
 All this logic will automatically be available in application.js.
 You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/ */

$(function() {
    $('#shoppingList li a').listRemoveButton();

    $('#addListItemForm').submit(function() {

        var valuesToSubmit = $(this).serialize();

        var name = $('input#list_item_name').val();

        $.ajax({
            url: $(this).attr('action'), // submits to the given URL
            type: "POST",
            data: valuesToSubmit,
            dataType: "JSON",
            success: function(json) {
                $('#shoppingList ul').append('<li>' + name + '<a href="#"></a></li>');
                $('#list_item_name').val('');
            },
            error: function(test) {
                alert("Fejl på siden");
            }
        })/*.success(function(json){
         $('#shoppingList ul').append('<li>test</li>');
         $('#shoppinglist ul').refresh();
         }); */
        return false;
    });
});