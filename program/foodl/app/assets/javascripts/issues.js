
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
    /*$('.report-button').on("click", function(){

    });*/

    $('.report-button').fancybox({
        type        : 'ajax',
        maxWidth	: 800,
        maxHeight	: 600,
        fitToView	: false,
        width		: '70%',
        height		: '70%',
        autoSize	: false,
        closeClick	: false,
        openEffect	: 'none',
        closeEffect	: 'none',
        ajax        : {
            url      : '/issues/new',
            dataType : 'text'
        }
    });

    return false;
});