$(function() {
  $( "#slider" ).slider({
    value:2,
    min: 1,
    max: 10,
    step: 1,
    slide: function( event, ui ) {
      $( "#amount" ).val( ui.value );
    }
  });
  $( "#amount" ).val( $( "#slider" ).slider( "value" ) );
});