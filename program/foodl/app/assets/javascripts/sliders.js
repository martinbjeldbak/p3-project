$(function() {
  $( "#amount-slider" ).slider({
    value:2,
    min: 1,
    max: 10,
    step: 1,
    slide: function( event, ui ) {
      $( "#amount" ).html( ui.value );
    }
  });
  $( "#amount" ).html( $( "#amount-slider" ).slider( "value" ) );

  $( "#prep-time" ).buttonset();

  $( "#sorting" ).buttonset();

  $( ".favour-button" ).button({
    icons: {
      primary: "ui-icon-heart"
    },
    text: false
  });
});