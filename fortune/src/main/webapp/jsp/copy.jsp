<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include-base.jsp"%>
<%@ include file="include-bootstrap.jsp"%>		
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%-- <link rel="icon" href="<%=basePath%>favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="<%=basePath%>favicon.ico" type="image/x-icon"> --%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>复制</title>
<style>
	.container {
		width:90%;
	}
	span {
		border:1px solid gray;
		padding:5px;
		margin:5px;
		display:inline-block;
	}
	select{
		height:30px;
	}
</style>
</head>
<body>
<div class="container" id="main">
	<div>
		<select id="format">
			<option value="span">span</option>
			<option value="pre">pre</option>
		</select>
		<input type='button' value='提交' onclick='save()' style="width:300px;height: 30px;display: inline-block;">
		<br>
		<input type="text" value='' id='title' name='title'>
		<textarea id="content" name="content" style="width:99%;height:150px;"></textarea>
	</div>
	<div id='result'>
		
	</div>
</div>
</body>
<script>
// 查询所有
$.ajax({
    url:'<%=basePath%>copy/getAll',
    data:{},
	type : 'get',
    dataType : 'json',
    contentType: "application/json; charset=utf-8",
	async : false,
	cache : false,
    success:function(json){
    	if(json) {
    		$("#result").empty();
    		for(var i=0;i<json.length;i++) {
    			var copy = json[i];
    			var title = copy.title;
    			
    			var html;
    			if(copy.format=='span') {
    				html = "<span id='"+copy.id+"'>"+copy.content+"</span>";
    			} else if(copy.format=='pre') {
    				html = "<pre id='"+copy.id+"'>"+copy.content+"</pre>";
    			}
    			if($("[title='"+title+"']").length == 0) {
    			    $('#result').after("<span style='display:inline-block;min-width:100px;background:yellow;text-align:center;font-weight:900;font-size:20px;' title='"+title+"'>"+title+"</span>");
    			} 	
    			$("[title='"+title+"']").after(html);
    			
    		}
    	}
    }
});
function save() {
	event.preventDefault();
	var json = {}
	json.format = $("#format").val();
	json.title = $("#title").val();
	json.content = $("#content").val();
	var jsonStr = JSON.stringify(json);
	$.ajax({
	    url : "<%=basePath%>copy/save",
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
$('span,pre').click(function(){
	copy($(this).text());
});

$("span,pre").bind("contextmenu", function(){
	var id = $(this).attr('id');
	// 删除
	event.preventDefault();
	$.ajax({
	    url : "<%=basePath%>copy/remove/"+id,
	    type : 'DELETE',
	    dataType : 'json',
	    contentType: "application/json; charset=utf-8",  
	    async : false,
	    cache : false,
	    data : {},
	    success: function(result) {
    		window.location.reload();
		}
	});		
})
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