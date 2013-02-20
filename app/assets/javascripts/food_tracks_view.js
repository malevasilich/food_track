$(function() {
	$( "#food_name" ).focus();
	$("#calendar").datepicker();

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

	// Enter as Tab in inputs
	$(':input').keypress(function(e){
	  if(e.which == 13){
	  		if (this.id=="food_name" && cache[ this.value ] != null && cache[ this.value ].length == 0) {
	  			// enter new product
	  			$('#new_food_window').show();
	  			$('#new_food_name').val(this.value);
	  			$('#new_food_p').focus();

	  			return false; //don't submit the parent form
	  		} else {
	  			if (this.type == "submit") {
	  				// check if all the values are present
	  				;
	  			} else {
			  		inputs = $(":input");
		  			inputs[inputs.index(this)+1].focus();
				    return false; //don't submit the form
				}
			}
	  }
	});

	$(document).keyup(function(e) {
	  if (e.keyCode == 27) { //esc 
	  	$('#new_food_window').hide(); 
  		$( "#food_name" ).focus();
	  }  
	});

	// new food form callbacks
	$('form#new_food_form').ajaxError(function(event, request, settings) {
		 //do some stuff on error
	})

	$('form#new_food_form').bind('ajax:success', function(evt, data, status, xhr){
		$('#new_food_window').css({display: 'none'});
		$('#food_track_weight').focus();
	})
});



