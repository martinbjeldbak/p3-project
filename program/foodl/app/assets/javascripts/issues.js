
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
    $('.report-button').fancybox({
      type        : 'ajax',
      fitToView	: false,
      autoSize	: true,
      closeClick	: false,
      openEffect	: 'none',
      closeEffect	: 'none',
      ajax        : {
          url      : '/issues/new',
          dataType : 'text'
      }
    });

    $('#issue_issue_category_id').live('change', function() {

      if ($(this).val() == "1") {
        $('p#descriptionBox').hide();
      } else {
        $('p#descriptionBox').show();
      }
    });
});