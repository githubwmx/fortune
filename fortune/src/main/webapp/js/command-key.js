$('body').bind('keyup', function(event) {
    if (event.keyCode == "13") { // enter
    	search();
    } else if(event.keyCode == '118') { // f7
    	toAdd();
    } else if(event.keyCode == '119') { // f8
    	save();
    } else if(event.keyCode == '120') { // f9
    	update();
    }
});