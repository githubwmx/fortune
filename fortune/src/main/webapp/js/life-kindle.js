
function autoDeal(textarea) {
	var pastedText = event.clipboardData.getData('text/plain'); 
	if (pastedText.indexOf('Kindle') != -1) {
		var text = kindle(pastedText);
		appendUE(ue, text);
	    $('#fromKindle').empty();
	}
}

function autoDealKindleTitle(textarea) {
	var pastedText = event.clipboardData.getData('text/plain'); 
	var text = kindle(pastedText);
	$('#title').val(text);
	$('#fromKindleToTitle').empty();
}

function kindle(pastedText) {
    event.preventDefault();
    var textArray = pastedText.split('\n').slice(0,-2);
    for(var i=0;i<textArray.length;i++) {
    	// 删除空格 
        textArray[i] = textArray[i].replace(/(?<![a-zA-Z])\s/g,"");
        textArray[i] = textArray[i].replace(/\s(?![a-zA-Z])/g,"");
    }
    return textArray.join('\n');
}

function copy(str) {
	let oInput = document.createElement('textarea');
	oInput.value = str
	document.body.appendChild(oInput)
	oInput.select()
	document.execCommand("Copy")
	oInput.style.display = 'none'
	document.body.removeChild(oInput)
}
