load_dietdairydb = function (searchstr) {
	$('#dietdairy_div').show();
	$('#dietdairy_qstr').val(searchstr);
	$('#dd_form').submit();
}

add_new_food = function (value){
	$('#new_food_window').show();
	$('#new_food_name').val(value);
	$('#new_food_p').focus();
	load_dietdairydb(value);
}

new_food_window_close_ok = function() {
		$('#food_name').val($('#new_food_name').val());
		$('#new_food_window').hide();
		$('#dietdairy_div').hide();
		$('#food_track_weight').focus();
		cache = {};
}

$(function() {
	$( "#food_name" ).focus();
	$("#calendar").datepicker();

	// JQuery autocomplete
	var cache = {};
	var value_set=0;
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
  		 ,select: function( event, ui ) {
		 	cache [ui.item.value] = [ui.item.value];
		 }
	});

	// Enter as Tab in inputs
	$(':input').keypress(function(e){
	  if(e.which == 13){
	  		if (this.id=="food_name" && !value_set && (cache[ this.value ] == null || cache[ this.value ].length == 0)) {
	  			// enter new product
	  			add_new_food(this.value);
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
	  	$('#dietdairy_div').hide(); 
  		$( "#food_name" ).focus();
	  }  
	});

	// new food form callbacks
	$('form#new_food_form').ajaxError(function(event, request, settings) {
		 //do some stuff on error
	})



	$('form#new_food_form').bind('ajax:success', function(evt, data, status, xhr){
		new_food_window_close_ok();
	})

});



