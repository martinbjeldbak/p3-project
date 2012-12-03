
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

    $('#issue_issue_category').live('change', function() {

      if ($(this).val() == "1") {
        $('p#descriptionBox').hide();
      } else {
        $('p#descriptionBox').show();
      }
    });


   $('#new_issue').submit(function() {
     var $issueCategoryID = $('#issue_issue_category').val();


     startLoading();
     $.ajax({
       url: $(this).attr('action'),
       type: "POST",
       data: {issue_cateogry: $issueCategoryID},
       dataType: "JSON",
       success: function(responseItem) {
         stopLoading();
         //TODO: roflmincopter - not done

       },
       error: function(xhr, error) {
         //alert("readyState: "+xhr.readyState+"\nstatus: "+xhr.status);

         // if(xhr.status == 500) {
         //     $(document.body).html(xhr.responseText);
         // }
         flashMessage("Der skette en fejl på siden. Prøv igen senere.", "error");
         stopLoading();
       }
     });
     return false;



   });
});