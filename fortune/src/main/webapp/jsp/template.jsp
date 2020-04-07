<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include-base.jsp"%>
<%@ include file="include-bootstrap.jsp"%>		
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>模板</title>
<style>
.container {
	width: 95% !important;
	margin:5px;
}
.labeltext {
	color: black;
	padding: 5px 10px;
	margin: 5px;
	border: 1px solid lightgray;
	display: inline-block !important;
	font-size: 18px;
	font-weight: normal;
	background:lightgray;
}
#inputs div {
	border:1px solid lightgray;
	padding:5px;
	display:inline-block;
}
#inputs div span {
	margin-right:10px;
}
</style>
</head>
<body style="text-align: center;" class='center-block'>
  <div class="container">
    <div id='labels'> </div>
	<div id='updateDiv'>
		<div>
			<input type="text" class="form-control" style="display: inline-block;width: 500px;" id="name" name="name" placeholder="名称" />
			<br>
			<textarea id='content' style="width: 100%;height: 400px;"></textarea>
			<br>
			<pre/>
		</div>
		<div class="row" style="text-align: center;" style="">
			<div style="padding: 10px;">
			  	<button class="btn btn-default" onclick="save()">新增</button>
			  	<button class="btn btn-default" onclick="update()">更新</button>
			</div>
		</div>
	</div>
	<div id='calc'>
		<div id='inputs'> </div>	
		<pre id='show'>
		</pre>
		<pre id='result'>
		</pre>
		<button class="btn btn-default" onclick="calc()">计算</button>
	</div>
  </div>
</body>
<script>
var addElements = "#updateDiv";
var calElements = "#calc";
function onCalc() {
	$(addElements).hide();
	$(calElements).show();
}
function onAdd() {
	$(addElements).show();
	$(calElements).hide();	
}
getAll();
onAdd();
function getAll() {
	$.ajax({
	    url : "<%=basePath%>template/getAll",
	    type : 'GET',
	    dataType : 'json',
	    contentType: "application/json; charset=utf-8",  
	    async : false,
	    cache : false,
	    data : {},
	    success: function(json) {
	    	for(var i=0;i<json.length;i++) {
	    		var obj = json[i];
	    		$('#labels').append("<span class='labeltext' onclick='setInfo(this)' id='"+obj.id+"'>"+obj.name+"</span>")	    		
	    	}
		}
	});	
}
function setInfo(this_) {
	onCalc();
	var id = $(this_).attr('id');
	$.ajax({
	    url : "<%=basePath%>template/getById",
	    type : 'GET',
	    dataType : 'json',
	    contentType: "application/json; charset=utf-8",  
	    async : false,
	    cache : false,
	    data : {
	    	"id":id
	    },
	    success: function(json) {
	    	$("#show").text(json.content).show();
	    	$("#updateDiv").hide();
	    	var array = $("#show").text().match(/\\$\{\w+\}/g);
	    	var map = {}; 
	    	for(var i=0;i<array.length;i++) {
	    		map[array[i]] = '';
	    	}
	    	for(var key in map) {
	    		$("#inputs").append("<div><span>"+key+"</span><input type='text' style='width:200px;'></div>");
	    	}
	    }
	});	
}
function calc() {
	var divs = $("#inputs div");
	var content = $("#show").text();
	for(var i=0;i<divs.length;i++) {
		var $div = $(divs[i]);
		var name = $div.find('span').text();
		var val = $div.find('input').val();
		for(var j=0;j<1000;j++) {
			content = content.replace(name,val);
		}
	}
	$("#result").text(content);
	copy(content);
}
function copy (str) {
    let oInput = document.createElement('textarea');
    oInput.value = str
    document.body.appendChild(oInput)
    oInput.select()
    document.execCommand("Copy")
    oInput.style.display = 'none'
    document.body.removeChild(oInput)
}
function save() {
	event.preventDefault();
	var json = {}
	json.name = $("#name").val();
	json.content = $("#content").val();
	var jsonStr = JSON.stringify(json);
	$.ajax({
	    url : "<%=basePath%>template/save",
	    type : 'POST',
	    dataType : 'json',
	    contentType: "application/json; charset=utf-8",  
	    async : false,
	    cache : false,
	    data : jsonStr,
	    success: function(result) {
    		window.location.reload();
		}
	});	
}
</script>
</html>