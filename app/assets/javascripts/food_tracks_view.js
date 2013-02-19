$(function() {
	$( "#food_name" ).focus();

	// JQuery autocomplete
	var cache = {};
	$( "#food_name" ).autocomplete({
		minLength: 2,
		autoFocus: true,
		source: function( request, response ) {
			var term = request.term;
			if ( term in cache ) {
				response( cache[ term ] );
				return;
		}
		$.getJSON( "foods/names.json", request, function( data, status, xhr ) {
			cache[ term ] = data;
			response( data );
		});
		}
	});

	// Enter as Tab
	$(':input').keypress(function(e){
	  if(e.which == 13){
	  		inputs = $("table :input");
  			inputs[inputs.index(this)+1].focus();
		    return false;
	  }
	});

});



