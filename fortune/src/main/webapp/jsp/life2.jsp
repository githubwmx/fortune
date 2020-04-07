<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include-base.jsp"%>
<%@ include file="include-bootstrap.jsp"%>		

	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.config.js"></script>
	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.all.js"></script>
	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.parse.js"></script>
	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/lang/zh-cn/zh-cn.js"></script>
	
	<script src="<%=basePath %>js/life-kindle.js"></script>
	<script src="<%=basePath %>js/life-key.js"></script>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>生活管理</title>
<style>
body {
    font-size: 18px !important;
}
.container {
	width:90% !important;		
}
.container p {
	margin:0px !important;
}
#categories {
    padding-top: 10px;
}
#categories .lightgray {
    background: tan;
    font-weight: bolder;
}

.label-type {
	color: black;
	padding: 5px 10px;
	margin: 5px;
	border: 1px solid lightgray;
	display: inline-block !important;
}
.label-category {
	color: black;
	padding: 5px 10px;
	margin: 5px;
	border: 1px solid lightgray;
	display: inline-block !important;
}
.labeltext {
	color: black;
	padding: 5px 5px;
	margin: 5px;
	border: 1px solid lightgray;
	display: inline-block !important;
	font-size: 18px;
	font-weight: normal;
	background:lightgray;
	min-width: 80px;
	text-align: center;
}
.border-bottom {
	border-bottom:1px solid lightgray;
	padding-bottom:0px;
}
#view-content {
	padding:5px;
	font-size: 18px;
}
pre {
	font-size: 14px !important;
}
#view-content {
    padding:5px;
    font-size: 18px !important;
}
#searchResult table td,#view-content table td{
    border:5px solid blue !important;
    padding:5px;
}
#searchResult table td ,#view-content table td {
    padding-top:2px !important;
    padding-left:8px !important;
    padding-bottom:4px !important;
}
#searchResult table td ,#view-content table td {
    padding-top:2px !important;
    padding-left:8px !important;
    padding-bottom:4px !important;
}
#viewPanels li {
    border:2px solid lightblue !important;
    margin-top: 10px;
    padding: 10px;
}

.list-paddingleft-2 {
    list-style-type: none !important;
    padding-left: 0px !important;
}
.list-paddingleft-2 li {
    background: lightgray !important;
    padding: 5px;
    margin-top: 10px;
}
#fromKindle {
    width: 1000px;
    height: 80px;
}
hr {
    margin-top: -5px !important;
}
.folder {
    border: 2px solid yellow;
}
</style>
</head>
<body>
	<div id="iframe" style="display: none;">
		<iframe src="" style="width: 100%;height: 800px;border:none;"></iframe>
	</div>
	<div id='know'>
		<div class="container" id='categories'> </div>
		<hr style="margin-top: 0px;"/>
		<div class="container" id='labels'> </div>
		<div class="container" id='view' style="border:1px solid gray;display: none;">
			<div id='view-title' style="font-weight: 900px !important;text-align: center;"></div>
			<div id='view-content' style=""></div>
		</div>
		<div class="container" id='viewPanels'>
		  <ul style="list-style-type:decimal"></ul>
		</div>
		<div class="container" style="padding: 5px 20px;">
			<input id='keyword' type="text" style="width: 500px;" autofocus="autofocus">
			<input type='button' value='搜索' id='search' onclick='search()' style="width:300px;height: 30px;display: inline-block;">
			<input type='button' value='新增' id='toAdd' onclick='showEdit()' style="width:300px;height: 30px;display: inline-block;">
		</div>
		<div id='searchResult' class="container">
		</div>
		<div class="container" id='updateDiv' style="display: none;">
			<div style="margin-bottom: 5px;">
				<input type="text" class="form-control" style="display: inline-block;width: 200px;" id="category_name" name="category_name" placeholder="类目名称" />
				<span class='blank'></span>
				<input type="text" class="form-control" style="display: inline-block;width: 500px;" id="title" name="title" placeholder="文章标题" />
				<span class='blank'></span>
				<input type="checkbox" id='is_folder' name="is_folder" value="1" style=""><label class="mr10">文件夹</label>
			</div>
			<textarea id='fromKindle' onpaste='autoDeal(this)'></textarea>
			<script id="ueditorContainer" type="text/plain" style="height: 480px;"> </script>
			<div class="row" style="text-align: center;" style="">
				<div style="padding: 10px;">
				  	<button class="btn btn-default" onclick="add()" id='submitBtn'>新增</button>
				  	<button class="btn btn-default" onclick="update()" id='updateBtn'>更新</button>
				</div>
			</div>
		</div>		
	</div>
</body>
<script type="text/javascript">
$(function(){
	$('*').each(function(index,this_){
		if($(this_).attr('id')) {
			$(this_).attr('title',$(this_).attr('id'));
		}
	})
})
function search() {
	var keyword = $("#keyword").val();
    $.ajax({
        url:'<%=basePath%>life/search?keyword='+keyword,
        data:{},
    	type : 'get',
	    dataType : 'json',
	    contentType: "application/json; charset=utf-8",
    	async : false,
    	cache : false,
        success:function(json){
        	if(json) {
        		$("#searchResult").empty();
        		for(var i=0;i<json.length;i++) {
        			var life = json[i];
        			life.title = ("【" + life.category_name + "】" + life.title).replace(keyword,"<span style='color:red'>"+keyword+"</span>")
        			life.content = life.content.replace(keyword,"<span style='color:red'>"+keyword+"</span>")
        			$("#searchResult").append("<div style='border:1px solid gray;margin-top:10px;margin-bottom:10px;padding:10px;'><h3 style='text-align:center'>"+life.title+"</h3><div>"+life.content+"</div></div>")
        		}
        	}
        }
    });		
}
getArticleNoCategory();
function getArticleNoCategory() {
    $.ajax({
        url:'<%=basePath%>life/getAllTitle',
        data:{},
    	type : 'get',
	    dataType : 'json',
	    contentType: "application/json; charset=utf-8",
    	async : false,
    	cache : false,
        success:function(json){
        	if(json) {
        		for(var i=0;i<json.length;i++) {
        			var life = json[i];
		        	$('#labels').append("<span class='lightgray' onclick='view(this)' ondblclick='setInfo(this)' id='"+life.id+"'>"+life.title+"</span>")
        		}
        	}
        }
    });				
}
getAllCategory();
function getAllCategory() {
	$.ajax({
	    url : "<%=basePath%>life/getAllCategory",
	    type : 'GET',
	    dataType : 'json',
	    async : false,
	    cache : false,
	    data : {},
	    success: function(json) {
	    	if(json) {
	    		for(var i=0;i<json.length;i++) {
	    			var obj = json[i];
	    			if(obj) {
		    			$("#categories").append("<span class='lightgray' onclick='getCategory(\""+obj[0]+"\")'>"+obj[0]+" ("+(obj[1])+")</span>");
	    			}
	    		}
	    	}
		}
	});	
}
function getCategory(name) {
    $.ajax({
        url:'<%=basePath%>life/getByCategory?name='+name,
    	type : 'get',
    	async : false,
    	cache : false,
        success:function(json){
        	$("#labels span").remove();
        	if(json) {
        		for(var i=0;i<json.length;i++) {
        			var life = json[i];
        			if(life.is_folder==1) { // 目录类
        				$('#labels').append("<span class='lightgray folder' onclick='openFolder(this)' ondblclick='setInfo(this)' id='"+life.id+"'>"+life.title+"</span>")
        			} else if(life.title) {
	        			$('#labels').append("<span class='lightgray' onclick='view(this)' ondblclick='setInfo(this)' id='"+life.id+"'>"+life.title+"</span>")
        			} else { // 笑话类只有类目和内容
        				var content= life.content;
        				$('#viewPanels ul').append("<li>"+content+"</li>");
        			}
        		}
        	}
        }
    });	
}
function showEdit() {
	$("#view,#searchResult").hide();
	$("#updateDiv").show();
	$('#category_name').focus();
}
function view(this_) {
	$("#view").show();
	$("#updateDiv").hide();
	id = this_.id;
	$(function(){
	    $.ajax({
	        url:'<%=basePath%>life/getById',
	        data:{
	        	'id':id
	        },
	    	type : 'get',
		    dataType : 'json',
		    contentType: "application/json; charset=utf-8",
	    	async : false,
	    	cache : false,
	        success:function(json){
	        	$("#view-title").html("<h3>【"+json.category_name+"】"+json.title+"</h3>");	
	        	$("#view-content").html(json.content);	
	        }
	    });		
	}) 	
}
var ue = UE.getEditor('ueditorContainer', {
    autoHeight: true
});
function add() {
	event.preventDefault();
	var json = {}
	json.category_name = $("#category_name").val();
	json.title = $("#title").val();
	json.content = UE.getEditor('ueditorContainer').getContent();
	json.is_folder = $("#is_folder").prop('checked')?1:0;
	var jsonStr = JSON.stringify(json);
	$.ajax({
	    url : "<%=basePath%>life/save",
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
function update() {
	event.preventDefault();
	var json = {}
	json.id = id;
	json.category_name = $("#category_name").val();
	json.title = $("#title").val();
	json.content = UE.getEditor('ueditorContainer').getContent();
	json.is_folder = $("#is_folder").prop('checked')?1:0;
	if(!json.title || !json.content) {
		return;
	}
	var jsonStr = JSON.stringify(json);
	$.ajax({
	    url : "<%=basePath%>life/update",
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
var id;
function setInfo(this_) {
	$("#updateDiv").show();
	$("#view").hide();
	id = this_.id;
	$(function(){
	    $.ajax({
	        url:'<%=basePath%>life/getById',
	        data:{
	        	'id':id
	        },
	    	type : 'get',
		    dataType : 'json',
		    contentType: "application/json; charset=utf-8",
	    	async : false,
	    	cache : false,
	        success:function(json){
	        	$("#category_name").val(json.category_name);
	        	$("#title").val(json.title);
	        	if(json.is_folder==1) {
		        	$("#is_folder").prop('checked',true);
	        	} else {
	        		$("#is_folder").removeProp('checked');
	        	}
		        UE.getEditor('ueditorContainer').setContent(json.content);
	        }
	    });		
	}) 	
}
function openIframe(url) {
	$("#know").hide();
	$("#iframe").show();
	$("#iframe iframe").attr('src',url);
}
function openKnow() {
	$("#iframe").hide();
	$("#know").show();
}
function openFolder(this_) {
    $.ajax({
        url:'<%=basePath%>life/openFolder',
        data:{
            'id':this_.id
        },
        type : 'get',
        dataType : 'json',
        contentType: "application/json; charset=utf-8",
        async : false,
        cache : false,
        success:function(json){
            
        }
    });     	
}
</script>
</html>