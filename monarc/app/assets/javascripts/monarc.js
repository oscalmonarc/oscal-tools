	   function showAPI(){
	   
		   	theurl  = "<%= URI.join request.url, '/' %>";
	   	currentURL = window.location.href;
	   	newURL = currentURL.replace(theurl, theurl+"api/v1/");
	   	document.location.href = newURL; 
    	
	}
	
	function displaySearchBar() {
    	
    	var tableVis = document.getElementById("search_table");
    	var displaySearch = document.getElementById("displaySearch");
    	if (tableVis.style.display === "none") {
	        tableVis.style.display = "block";
	         displaySearch.innerHTML = "-";
	    } else {
        	tableVis.style.display = "none";
        	displaySearch.innerHTML = "+";
    	}	
	};
	
	function grabFromApi(theURL){
		return fetch(theURL)
		.then((resp) => resp.json())
		.then(function(data) {
			
			return data; // Get the results
	  })
	};
	
	function createNode(element) {
	      return document.createElement(element);
	  }
	
    function append(parent, el) {
	    return parent.appendChild(el);
	 }

    function grabControlsForSelectFromAPI(theURL, selected_control){
		var converted_controls = "";
		return grabFromApi(theURL).then((controls) => {
			if(controls) {
			    var arrayLength = controls.length;
			    for (var i = 0; i < arrayLength; i++) {
			    	converted_controls = converted_controls + " <option value='" + controls[i].id + "'";
			    	if (selected_control === controls[i].id)  {
			    		converted_controls = converted_controls + " selected ";
			    	}
			    	converted_controls = converted_controls + ">" + controls[i].name + "</option>";
			    }
			    //console.log(converted_controls);
			    return converted_controls;    
			}
		  })
	}
  
    //jQuery extension method:
	jQuery.fn.filterByText = function(textbox) {
	  return this.each(function() {
	    var select = this;
	    var options = [];
	    $(select).find('option').each(function() {
	      options.push({
	        value: $(this).val(),
	        text: $(this).text()
	      });
	    });
	    $(select).data('options', options);
	
	    $(textbox).bind('change keyup', function() {
	      var options = $(select).empty().data('options');
	      var search = $.trim($(this).val());
	      var regex = new RegExp(search, "gi");
	
	      $.each(options, function(i) {
	        var option = options[i];
	        if (option.text.match(regex) !== null) {
	          $(select).append(
	            $('<option>').text(option.text).val(option.value)
	          );
	        }
	      });
	    });
	  });
	};
    
	
	
	