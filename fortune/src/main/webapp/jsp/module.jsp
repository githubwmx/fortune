<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include-base.jsp"%>
<%@ include file="include-bootstrap.jsp"%>		
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title></title>
	<style>
		select {
			width:400px;
			height:30px;
		}
	</style>
</head>
<body>
	<div class="container">
	<div id='table' style="padding: 5px;">
		<textarea name="content" id="content" style="width: 100%;height: 400px;margin-bottom: 5px;"></textarea>
		<input type="button" onclick='submitTable()' value="提交表定义">
	</div>
	<div id='relation' style="padding: 5px;">
		<button onclick='addRow(this)'>新增</button>
		<button onclick='generate(this)'>生成</button>
		<button onclick='vo2DB(this)'>VO属性转DB属性</button>
		<div>
			<select id='master' style="margin-top: 5px;"></select>
		</div>
	</div>
	<div id='hidden' style="display: none;padding: 5px;">
		<div>
			<select id='relations'>
				<option value="1:N">1:N</option>
				<option value="1:1">1:1</option>
				<option value="N:1">N:1</option>
			</select>
			<select id='slaves'></select>
		</div>	
	</div>
	<pre id='result'>
	</pre>
	</div>
</body>
<script type="text/javascript">
function addRow(this_) {
	var html = $("#hidden").html();
	$("#master").after(html);
}
function vo2DB(this_) {
	event.preventDefault();
	var json = {}
	json.master = $("#master").val();
	var jsonStr = JSON.stringify(json);
	$.ajax({
	    url : "<%=basePath%>module/vo2DB",
	    type : 'POST',
	    dataType : 'json',
	    contentType: "application/json; charset=utf-8",  
	    async : false,
	    cache : false,
	    data : jsonStr,
	    success: function(result) {
	    	$("#result").text(result.result);
	    	copy(result.result);
	    }
	});		
}
function generate(this_) {
	event.preventDefault();
	var json = {}
	json.master = $("#master").val();
	//
	var slaves = $("#relation #slaves");
	var slavesStr='';
	for(var i=0;i<slaves.length;i++) {
		if(i==0) {
			slavesStr += $(slaves[i]).val();
		} else {
			slavesStr += ',' + $(slaves[i]).val();
		}
	}
	json.slaves = slavesStr;
	//
	var relations = $("#relation #relations");
	var relationsStr='';
	for(var i=0;i<relations.length;i++) {
		if(i==0) {
			relationsStr += $(relations[i]).val();
		} else {
			relationsStr += ',' + $(relations[i]).val();
		}
	}
	json.relations = relationsStr;
	//
	var jsonStr = JSON.stringify(json);
	$.ajax({
	    url : "<%=basePath%>module/generate",
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
var modules = {};
$.ajax({
    url : "<%=basePath%>module/getAll",
    type : 'GET',
    dataType : 'json',
    contentType: "application/json; charset=utf-8",  
    async : false,
    cache : false,
    data : {},
    success: function(json) {
   		modules = obj;
    	for(var i=0;i<json.length;i++) {
    		var obj = json[i];
    		$("#master,#slaves").append("<option value='"+obj.table_name+"'>"+obj.table_comment+"</option>");	    		
    	}
    }
});
function submitTable() {
	event.preventDefault();
	var json = {}
	json.name = $("#name").val();
	json.content = $("#content").val();
	var jsonStr = JSON.stringify(json);
	$.ajax({
	    url : "<%=basePath%>module/save",
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
function copy (str) {
    let oInput = document.createElement('textarea');
    oInput.value = str
    document.body.appendChild(oInput)
    oInput.select()
    document.execCommand("Copy")
    oInput.style.display = 'none'
    document.body.removeChild(oInput)
}
</script>
</html>