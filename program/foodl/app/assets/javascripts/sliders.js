$(function() {
  $( "#amount-slider" ).slider({
    value:2,
    min: 1,
    max: 10,
    step: 1,
    slide: function( event, ui ) {
      $( "#amount" ).html( ui.value );
	  $( "#recipe-result > ul ul > li > span" ).each( function(index, element){
		var amount = parseFloat( $(this).data( "value" ) );
		amount = amount * parseInt( ui.value );
		var text = amount.toFixed( 2 );
		text = text.replace( ".", "," );
		
		if( text == "0,25" ) text = "1/4";
		else if( text == "0,33" ) text = "1/3";
		else if( text == "0,50" ) text = "1/2";
		else if( text == "0,66" ) text = "2/3";
		else if( text == "0,75" ) text = "3/4";
		else{
			var splittet = text.split( "," );
			text = splittet[0];
			if( splittet.length > 1 ){
				if( splittet[1] != "00" ){
					if( splittet[1][1] == '0' )
						text += "," + splittet[1][0];
					else
						text += "," + splittet[1];
				}
			}
		}
		
		$(this).html( text );
	  } );
    }
  });
  $( "#amount" ).html( $( "#amount-slider" ).slider( "value" ) );

  $( "#prep-time" ).buttonset();

  $( "#sorting" ).buttonset();

});
