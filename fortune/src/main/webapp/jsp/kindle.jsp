<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include-base.jsp"%>
<%@ include file="include-bootstrap.jsp"%>		
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>字符串工具</title>
<style>
.container {
	width: 90% !important;
}
.label {
	color: black;
	padding: 5 10px;
	margin: 5px;
	border: 1px solid gray;
}
</style>
</head>
<body>
	<div class="container">
		<textarea style="width: 100%;height: 300px;" onpaste='autoDeal(this)'></textarea>
		<br><br>
		<br><br><pre id='result'></pre>
	</div>
</body>
<script type="text/javascript">
$(function(){
	responseEsc();
})
function self() {
	event.preventDefault();
	var title = $('#title').val();
	var text = $('textarea').val();
	var json = {}
	json.content = text;
	json.title = title;
	var jsonStr = JSON.stringify(json);
	$.ajax({
	    url : "<%=basePath%>string/self",
	    type : 'POST',
	    dataType : 'json',
	    contentType: "application/json; charset=utf-8",  
	    async : false,
	    cache : false,
	    data : jsonStr,
	    success: function(json) {
 			$("#result").html(json.result);   		
		}
	});	
}
function columnAlias() {
	event.preventDefault();
	var title = $('#title').val();
	var text = $('textarea').val();
	var json = {}
	json.content = text;
	json.title = title;
	var jsonStr = JSON.stringify(json);
	$.ajax({
	    url : "<%=basePath%>string/columnAlias",
	    type : 'POST',
	    dataType : 'json',
	    contentType: "application/json; charset=utf-8",  
	    async : false,
	    cache : false,
	    data : jsonStr,
	    success: function(json) {
 			$("#result").html(json.result);   		
		}
	});	
}
function vo2Bean() {
	event.preventDefault();
	var title = $('#title').val();
	var text = $('textarea').val();
	var json = {}
	json.title = title;
	json.content = text;
	var jsonStr = JSON.stringify(json);
	$.ajax({
	    url : "<%=basePath%>string/vo2Bean",
	    type : 'POST',
	    dataType : 'json',
	    contentType: "application/json; charset=utf-8",  
	    async : false,
	    cache : false,
	    data : jsonStr,
	    success: function(json) {
 			$("#result").html(json.result);   		
		}
	});	
}
function kindle(pastedText) {
    event.preventDefault();
    var text = $('textarea').val()?$('textarea').val():pastedText;
    var textArray = text.split('\n').slice(0,-2);
    for(var i=0;i<textArray.length;i++) {
    	// 删除空格 
        textArray[i] = textArray[i].replace(/(?<![a-zA-Z])\s+/g,"");
        textArray[i] = textArray[i].replace(/\s+(?![a-zA-Z])/g,"");
    }
    $("#result").html(textArray.join('\n'));
    copy($("#result").html());
    $('textarea').empty();
}
function autoDeal(textarea) {
    if (window.clipboardData && window.clipboardData.getData) { // IE
		pastedText = window.clipboardData.getData('Text');
	} else {
		pastedText = event.clipboardData.getData('text/plain'); 
	}
	if (pastedText.indexOf('Kindle') != -1) {
		kindle(pastedText);
	}
}
</script>
</html>