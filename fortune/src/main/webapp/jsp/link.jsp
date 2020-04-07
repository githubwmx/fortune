<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include-base.jsp"%>
<%@ include file="include-bootstrap.jsp"%>		
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件夹管理</title>
<style>
.container {
	width: 90% !important;
}
.label {
	color: black;
	padding: 10px;
	margin: 5px;
	border: 1px solid gray;
	display: inline-block !important;
	font-size:16px;
}
.inline {
    display: block !important;
    text-align: left !important;
}
</style>
</head>
<body>
	<br><br>
	<div class="container" id='labels'>
	</div>
	<div class="container" id='tree'>
	</div>
	<br>
	<div class="container" id=''>
		<div>
			<input type="hidden" name='id' id='id'/>
			
			类别
			<input type="text" class="form-control" style="display: inline-block;width: 200px;" id="category" name="category" placehoder="类别" title=""/>
			<span style="display: inline-block;width:50px;"></span>
			
			名称
			<input type="text" class="form-control" style="display: inline-block;width: 200px;" id="name" name="name" placehoder="名称" title=""/>
			<span style="display: inline-block;width:50px;"></span>
			
			路径
			<input type="text" class="form-control" style="display: inline-block;width: 500px;" id="path" name="path" placehoder="路径" title=""/>
		</div>
		<br>
		<div class="row" style="text-align: center;">
			<br>
		  	<button class="btn btn-default" onclick="add()">新增</button>
		  	<button class="btn btn-default" onclick="update()">更新</button>
		</div>
	</div>
</body>
<script type="text/javascript">
	search();
	function search() {
	    $.ajax({
	        url:'<%=basePath%>folder/getAll',
	        data:{},
	    	type : 'get',
		    dataType : 'json',
		    contentType: "application/json; charset=utf-8",
	    	async : false,
	    	cache : false,
	        success:function(json){
	        	if(json) {
	        		var exist = {};
	        		for(var i=0;i<json.length;i++) {
	        			var folder = json[i];
	        			var cat = folder.category;
	        			if(!exist[cat]) {
	        				$('#labels').append("<h1>"+cat+"</h1>");
	        				exist[cat] = cat;
	        			} 
	        			$('#labels').append("<span class='label' onclick='explore("+folder.id+")' onmousedown='mouseDown(this)' id='"+folder.id+"'>"+folder.name+"</span>")
	        		}
	        	}
	        }
	    });				
	}
	function add() {
		event.preventDefault();
		var json = {}
		json.category = $("#category").val();
		json.name = $("#name").val();
		json.path = $("#path").val();
		var jsonStr = JSON.stringify(json);
		$.ajax({
		    url : "<%=basePath%>folder/save",
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
	var id;
	function update() {
		event.preventDefault();
		var json = {}
		json.id = id;
		json.name = $("#name").val();
		json.path = $("#path").val();
		var jsonStr = JSON.stringify(json);
		$.ajax({
		    url : "<%=basePath%>folder/update",
		    type : 'PUT',
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
	function explore(id) {
		$.ajax({
		    url : "<%=basePath%>folder/explore?id="+id,
		    type : 'GET',
		    dataType : 'json',
		    contentType: "application/json; charset=utf-8",  
		    async : false,
		    cache : false,
		    data : {},
		    success: function(result) {
			}
		});
	}
	function mouseDown(this_) {
		event.preventDefault();
		if(window.event.button == 2) {
			setInfo(this_.id);
		}
	}
	function setInfo(curId) {
		id = curId;
	    $.ajax({
	        url:'<%=basePath%>folder/getById?id='+id,
	        data:{},
	    	type : 'get',
		    dataType : 'json',
		    contentType: "application/json; charset=utf-8",
	    	async : false,
	    	cache : false,
	        success:function(json){
	        	if(json) {
	        		$("#category").val(json.category);		
	        		$("#name").val(json.name);		
	        		$("#path").val(json.path);		
	        	}
	        }
	    });			
	}
</script>
</html>