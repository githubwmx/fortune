// 复制字符串到剪贴板
function copy (str) {
    let oInput = document.createElement('textarea');
    oInput.value = str
    document.body.appendChild(oInput)
    oInput.select()
    document.execCommand("Copy")
    oInput.style.display = 'none'
    document.body.removeChild(oInput)
}

function toJson(object) {
	return JSON.stringify(object);
}
function fromJson(str) {
	return JSON.parse(str);
}

/********************* key *********************/
function responseEsc() {
	$('body').bind('keyup', function(event) {
	    if (event.keyCode == "27") { // esc
	    	window.close();
	    }
	});
}
/********************* html *********************/
function spanRed(text) {
	return "<span style=\"color:red\">"+text+"</span>";
}

/********************* window *********************/
function openWindow(url) {
	window.open(url, "_blank", "scrollbars=yes,resizable=1,modal=true,alwaysRaised=no");
}

/********************* kindle *********************/
function appendUE(ue, text) {
	if(ue.getContentTxt()) {
		ue.setContent(text, true);
	} else {
		ue.setContent(text);
	}
}
