<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include-base.jsp"%>
<%@ include file="include-bootstrap.jsp"%>		

	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.config.js"></script>
	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.all.js"></script>
	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.parse.js"></script>
	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/lang/zh-cn/zh-cn.js"></script>
	
	<script src="<%=basePath %>js/article-review.js"></script>
	<script src="<%=basePath %>js/article-key.js"></script>
	
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>知识管理</title>
<style>
/*临时调色修改*/
/* body { */
/*     background-color: #130303 !important; */
/*     color:red !important; */
/* } */
/* .label-category { */
/*     color: inherit !important;  */
/* } */

.container {
	width:90% !important;
}
.container p {
	margin:2px !important;
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
	font-size: 16px;
	font-weight: normal;
	background:lightgray;
}
.border-bottom {
	border-bottom:1px solid lightgray;
	padding-bottom:0px;
}
#view-content {
	padding:5px;
	font-size: 16px !important;
}
#view-content table td {
    padding:5px;
    font-size: 16px;
}
#searchResult tr, #view-content tr {
    border:3px solid green !important;
}
/* #searchResult tr:nth-child(odd), #view-content tr:nth-child(odd) { */
/*     font-weight: 900; */
/*     font-size: xx-large; */
/* } */
#searchResult table td ,#view-content table td {
    padding: 10px;
}

pre {
	font-size: 16px !important;
}
p {
    font-size: 16px !important;
}
body {
    font-family: "Microsoft Yahei", 微软雅黑, Helvetica, PingFangSC, Arial, sans-serif;
}
.category-border {
    border:3px solid blue;
}
ul.list-paddingleft-2 {
    list-style-type: none !important;
    padding-left: 0px !important;
}
ul.list-paddingleft-2 li {
    background: lightgray !important;
    padding: 2px;
    margin-top: 10px;
}
#menus {
    position: fixed;
    top: 10px;
    left: 10px;
    font-weight: 900;
    padding-bottom: 300px;
    padding-right: 30px;
}
#menus span, #menus a {
    display: block;
    background: tan;
    margin: 10px;
    margin-left: -5px;
    height: 75px;
    text-align: center;
    vertical-align: middle;
    line-height: 80px;
    border-radius: 40%;
}
#review {
    font-size: 16px;
}
#review #view-title {
    font-size: 20px;
}
#links a {
    margin-right: 5px;
}
div#view {
    width: 94% !important;
    margin-right: 10px;
}
</style>
</head>
<body>
    <!-- 链接 -->
    <div class="container" id='links'>
        <a href='<%=basePath %>jsp/test-jsp.jsp' target="_blank">测试页</a>
        
        <span class='back'>demo</span>
        <a onclick="openIframe('http://localhost:9000/jsp/demo-bootstrap.jsp')">bootstrap</a>
        
        <span class='back'>工具</span>
        <a href='https://start.spring.io/' target="_blank">spring initializr</a>
        <a href='http://www.bejson.com/' target="_blank">json</a>
        <a href='http://www.bejson.com/devtools/properties2yaml/' target="_blank">yarn</a>
        <a href='http://www.fhdq.net/#teshufuhao' target="_blank">emoji</a>
        
        <span class='back'>工作</span>
        <a href='https://mail.qq.com/' target="_blank">qq邮箱</a>         
        <a href='https://fanyi.baidu.com' target="_blank">百度翻译</a>
        
        <span class='back'>生活</span>
        <a href='https://www.amazon.cn/' target="_blank">亚马逊</a>          
        <a href='https://www.amazon.cn/gp/registry/wishlist' target="_blank">亚马逊心愿单</a>          
        <a href='https://www.taobao.com/' target="_blank">淘宝</a>     
        <a href='https://www.jd.com' target="_blank">京东</a>     
        
        <span class='back'>教程</span>
        <a href='https://www.roncoo.com/' target="_blank">龙果学院</a>          

        <span class='back'>文档</span>
        <a href='https://www.runoob.com/docker/docker-tutorial.html' target="_blank">docker</a>          
        <a href='https://www.runoob.com/cprogramming/c-tutorial.html' target="_blank">C语言</a>          
        <a href='https://www.runoob.com/python3/python3-tutorial.html' target="_blank">python3.x</a>          
        <a href='https://www.runoob.com/vue2/vue-tutorial.html' target="_blank">vue</a>          
        <a href='https://www.w3cschool.cn/hadoop/' target="_blank">hadoop</a>          
        <a href='https://hadoop.apache.org/docs/stable/' target="_blank">hadoop官网</a>          
        <a href='https://www.w3cschool.cn/hbase_doc/' target="_blank">hbase</a>          
             
    </div>  
    <!-- function -->
	<div class="" id='menus'>
		<span class='' onclick="openIframe('http://localhost:9000/jsp/path.jsp')">路径</span>
		<span class='' onclick="openIframe('http://localhost:9000/jsp/column.jsp')">列</span>
		<span class='' onclick="openIframe('http://localhost:9000/jsp/kindle.jsp')">kindle</span>
		<span id='folder' class='' onclick="openIframe('http://localhost:9000/jsp/folder.jsp')">文件夹</span>
		<span id='command' class='' onclick="openIframe('http://localhost:9000/jsp/command.jsp')">command</span>
		<span class='' onclick="openIframe('http://localhost:9000/jsp/copy.jsp')">复制</span>
		<span class='' onclick="openIframe('http://localhost:9000/jsp/database-manage.jsp')">数据库管理</span>
		<a class='' href='http://localhost:9000/jsp/database.jsp' target="_blank">数据库</a>
		
<!-- 		<span class='' onclick="openIframe('http://localhost:9000/jsp/module.jsp')">模块</span> -->
<!-- 		<span class='' onclick="openIframe('http://localhost:9000/jsp/html2.jsp')">html</span> -->
	</div>
	<div id="iframe" style="display: none;">
		<iframe name='pageIframe' src="" style="width: 100%;height: 2000px;;border:none;"></iframe>
	</div>
	<div id='know'>
	    <!-- 类目 -->
		<div class="container border-bottom" id='categories'> </div>
		<!-- 类目标签 -->
		<div class="container" id='labels'> </div>
		<!-- 搜索框 -->
		<div class="container" style="padding: 5px 16px;">
			<input id='keyword' type="text" style="width: 500px;" autofocus="autofocus">
			<input id='search' type='button' value='搜索' onclick='search()' style="width:300px;height: 30px;display: inline-block;">
			<input id='toAdd' type='button' value='新增' onclick='showEdit()' style="width:300px;height: 30px;display: inline-block;">
		</div>
		<!-- 标签查看 -->
		<div class="container" id='view' style="border:1px solid red;display: none;">
		    <input id='view-id' type="hidden"></input>
			<div id='view-title' style="font-weight: 900px !important;text-align: center;"></div>
			<div id='view-content' style=""></div>
		</div>
		<!-- 查询结果 -->
		<div id='searchResult' class="container">
		</div>
		<!-- 编辑区 -->
		<div class="container" id='updateDiv' style="display: none;">
			<div style="margin-bottom: 5px;">
				<input type="text" class="form-control" style="display: inline-block;width: 200px;" id="category_name" name="category_name" placeholder="类目名称" autocomplete='on'/>
				<span style="display: inline-block;width:50px;"></span>
				<input type="text" class="form-control" style="display: inline-block;width: 300px;" id="title" name="title" placeholder="文章标题" />
				<span style="display: inline-block;width:50px;"></span>
				<input type="text" class="form-control" style="display: inline-block;width: 200px;" id="label" name="label" placeholder="二级分类" />
				<input type="text" class="form-control" style="display: inline-block;width: 400px;" id="optimization" name="optimization" placeholder="搜索优化" />
			</div>
			<script id="ueditorContainer" type="text/plain" style="height: 480px;"> </script>
			<div id='area' class="row p10" style="text-align: center;" style="">
			  	<button id='submitBtn' class="btn btn-default" onclick="addOrUpdate()">提交</button>
				<div id='' style="padding: 10px;height: 400px;">
				</div>
			</div>
		</div>		
		<!-- 复习区 -->
        <div class="container p10" id='review' style="border:5px solid green;margin-top:100px;">
            <span id='tooltip' style="display: inline-block;margin-right: 16px;color:red;"></span><button onclick="nextReview()">下一题</button>
            <div id='view-title' style="font-weight: 900px !important;text-align: center;"></div>
            <div id='view-content' style=""></div>
            <br><br>
        </div>		
        <br>
	</div>
</body>
<script type="text/javascript">
$(function(){
	window.setTimeout(function(){
	    window.scrollTo(0,0);
	});
	// 记住上次点击的类目
	var lastCategory = localStorage.getItem('lastCategory');
	if(lastCategory) {
		getCategory(lastCategory);
		// 选中打开的类目
		$("span:contains('"+lastCategory+"')").addClass('category-border');
	}
	
	// 为类目添加颜色
	var words = [
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
	];
	var cats = $('.label-category');

	var lastC;
	var lastColor;
	for(var i=0;i<cats.length;i++) {
		
		var cat = $(cats[i]);
		var text = cat.text();
		var c = text.charAt(0);
		
		if(text.startsWith('✔') || text.startsWith('[')) {
			continue;
		}
		
		if(c==lastC) {
			cat.css('background-color', lastColor);	
		} else {
			var nowColor = lastColor=='#FFF68F'?'#D1EEEE':'#FFF68F';
			cat.css('background-color', nowColor);
			lastColor = nowColor;
		}
		lastC = c;
	}
	// 当输入框有输入时 主动匹配类目
	$('#keyword').keyup(function(){
		var keyword = $(this).val();
		var hasClick=false;
		
        if(keyword && keyword.length>=3) {
        	if(keyword.indexOf(' ') == -1) {
	            for(var i=0;i<cats.length;i++) {
	               var cat = $(cats[i]);
	               var text = cat.text();
	               if(text.startsWith(keyword)) {
	                   cat.css('border-color', 'red');
	                   cat.css('border-width', '3px');
	                   if(!hasClick) {
	                       cat.click();
	                       hasClick=true;
	                   }
	               }
	            }
	            // 如果标签中存在则选中
	            var eachIsClick= false;
	            $('.labeltext').each(function(){
	            	if($(this).text().indexOf(keyword) != -1) {
	            		if(!eachIsClick) {
		            		$(this).click();
		            		$('.labeltext').css('border-color', 'black')
		            		$('.labeltext').css('border-width', '1px');
		                    $(this).css('border-color', 'red');
		                    $(this).css('border-width', '3px');
		                    eachIsClick = true;
	            		}
	            	}
	            });
        	} else {
        		// 用输入字符串的第2部分选中标签
		        var second = keyword.split(' ')[1];
		        var hasClicked = false;
		        $('.labeltext').each(function(){
		        	var opt = $(this).attr('optimization');
		            if(second.length>=2 && ($(this).text().toLowerCase().indexOf(second) != -1 || (opt && optIndexOf(opt, second) != -1))) {
                        $('.labeltext').css('border-color', 'black')
                        $('.labeltext').css('border-width', '1px');
		                $(this).css('border-color', 'red');
		                $(this).css('border-width', '3px');
		                if(!hasClicked) {
		                	$(this).click();	
		                	hasClicked = true;
		                }
		            }
		        });        
        	}
       }
	});
});
function optIndexOf(opt, second) {
	var result = -1;
	var arr = opt.split(" ");
	for(var i=0;i<arr.length;i++) {
		var str = arr[i];
		if(str.startsWith(second)) {
			result = 1;
			break;
		}
	}
	return result;
}
function search() {
	var keyword = $("#keyword").val();
    $.ajax({
        url:'<%=basePath%>article/search?keyword='+keyword,
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
        			var article = json[i];
        			article.title = ("<span style='color:blue'>" + article.category_name + " </span>" + article.title).replace(keyword,"<span style='color:red'>"+keyword+"</span>")
        			article.content = article.content.replace(keyword,"<span style='color:red'>"+keyword+"</span>")
        			$("#searchResult").append("<div ondblclick='setInfo(this)' id='"+article.id+"' style='border:1px solid gray;margin-top:10px;margin-bottom:10px;padding:10px;'><h3 style='text-align:center'>"+article.title+"</h3><div>"+article.content+"</div></div>")
        		}
        	}
        }
    });		
}
// getArticleNoCategory();
function getArticleNoCategory() {
    $.ajax({
        url:'<%=basePath%>article/getAllTitle',
        data:{},
    	type : 'get',
	    dataType : 'json',
	    contentType: "application/json; charset=utf-8",
    	async : false,
    	cache : false,
        success:function(json){
        	if(json) {
        		for(var i=0;i<json.length;i++) {
        			var article = json[i];
		        	$('#labels').append("<span class='labeltext' onclick='view(this)' ondblclick='setInfo(this)' id='"+article.id+"'>"+article.title+"</span>")
        		}
        	}
        }
    });				
}
getAllCategory();
function getAllCategory() {
	$.ajax({
	    url : "<%=basePath%>article/getAllCategory",
	    type : 'GET',
	    dataType : 'json',
	    async : false,
	    cache : false,
	    data : {},
	    success: function(json) {
	    	if(json) {
	    		var firstStar = true;
	    		var firstTool = true;
	    		for(var i=0;i<json.length;i++) {
	    			var obj = json[i];
	    			if(obj) {
	    			    $("#categories").append("<span class='label-category' onclick='getCategory(\""+obj[0]+"\")'>"+obj[0]+" ("+(obj[1])+")</span>");
	    			}
	    		}
	    	}
		}
	});	
}
function getCategory(name) {
	localStorage.setItem('lastCategory', name);
	lastCategory = name;
	$('span').removeClass('category-border');
	$("span:contains('"+lastCategory+"')").addClass('category-border');
    $.ajax({
        url:'<%=basePath%>article/getByCategory?name='+name,
    	type : 'get',
    	async : false,
    	cache : false,
        success:function(json){
        	$(".labeltext").remove();
        	if(json) {
        		var showedLabels = [];
        		for(var i=0;i<json.length;i++) {
        			var article = json[i];
        			var label = article.label;
        			if(label && $.inArray(label, showedLabels) == -1) {
        				$('#labels').append("<span class='labeltext' style='background-color:AntiqueWhite;min-width:100px;text-align:center;'>"+article.label+"</span>")
        				showedLabels.push(label);
        			}
        			$('#labels').append("<span class='labeltext' optimization='"+article.optimization+"' onclick='view(this)' ondblclick='setInfo(this)' id='"+article.id+"'>"+article.title+"</span>")
        		}
        	}
        }
    });	
}
function showEdit() {
	$("#view,#searchResult").hide();
	$("#updateDiv").show();
}
function view(this_) {
	$("#view").show();
	$("#updateDiv").hide();
	$(function(){
	    $.ajax({
	        url:'<%=basePath%>article/getById',
	        data:{
	        	'id':this_.id
	        },
	    	type : 'get',
		    dataType : 'json',
		    contentType: "application/json; charset=utf-8",
	    	async : false,
	    	cache : false,
	        success:function(json){
	        	$("#view-id").val(json.id);
	        	$("#view-title").html("<h3><span style='color:blue'>"+json.category_name+" </span>"+json.title+"</h3>");	
	        	$("#view-content").html(json.content);	
        	    $('.list-paddingleft-2').bind('click',function(){
        	        var text = '';
        	        $(this).nextUntil('ul').each(function(){
        	            text += $(this).text()+"\n";    
        	        })
        	        copy(text);
        	    })  
	        	$("#view").one('dblclick',function(){
	        		setInfo({id:json.id});
	        	})
	        }
	    });		
	    restTableWidth();
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
	json.label = $("#label").val();
	json.optimization = $("#optimization").val();
	json.content = UE.getEditor('ueditorContainer').getContent();
	var jsonStr = JSON.stringify(json);
	$.ajax({
	    url : "<%=basePath%>article/save",
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
	json.label = $("#label").val();
	json.optimization = $("#optimization").val();
	json.content = UE.getEditor('ueditorContainer').getContent();
	if(!json.title || !json.content) {
		return;
	}
	var jsonStr = JSON.stringify(json);
	$.ajax({
	    url : "<%=basePath%>article/update",
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
	$("#searchResult").hide();
	id = this_.id;
	$(function(){
	    $.ajax({
	        url:'<%=basePath%>article/getById',
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
	        	$("#label").val(json.label);
	        	$("#optimization").val(json.optimization);
	        	console.log(json.content);
		        UE.getEditor('ueditorContainer').setContent(json.content);
	        }
	    });		
	}) 	
}
function addOrUpdate() {
	if(id) {
		update();
	} else {
		add();
	}
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
function restTableWidth() {
	window.setTimeout(function(){
		var rows = $('.firstRow');
	    for(var i=0;i<rows.length;i++) {
	        var row = rows[i];
	        $(row).find("td:eq(1)").width('80%').css('width','80%');
// 		    $(row).find("td:eq(0)").width('300px').css('width','300px');
// 		    var width = parseInt($(row).find("td:eq(0)").width());
// 		    if(width > 400) { // 并没有起作用
// 			    $(row).find("td:eq(1)").width('80%').css('width','80%');
// 		    }
	    }	
	},0);
}
</script>
</html>