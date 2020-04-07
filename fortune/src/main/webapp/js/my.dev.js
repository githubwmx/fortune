function key() {
	$('body').bind('keyup', function(event) {
		console.log("event.keyCode == '"+event.keyCode+"'")
	});
}
//打开开发模式
function dev() {
	$('div').css('outline-style','dotted').css('padding-top','10px').css('padding-left','10px');
	$("*").attr('title',function(){
		var title = '';
		if($(this).attr('id')) {
			title += "#" + $(this).attr('id') + "\n";
		} 
		if($(this).attr('class')) {
			title += "." + $(this).attr('class') + "\n"; 
		} 
		if($(this)[0].onclick) {
			title += $(this)[0].onclick.toString().trim() + "\n";
		}
		return title;
	});
}
