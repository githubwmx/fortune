<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include-base.jsp"%>
<%@ include file="include-bootstrap.jsp"%>		

	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.config.js"></script>
	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.all.js"></script>
	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.parse.js"></script>
	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/lang/zh-cn/zh-cn.js"></script>

	<script src="<%=basePath %>js/command-key.js"></script>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>命令</title>
<style type="text/css">
body {
    font-size: 20px;
}
.container {
    width: 90%;
}
legend {
    margin-bottom: 0px;
}
xmp {
    display: inline-block;
}
.container {
    margin-top: 10px;
    padding: 10px;
}
.show {
    padding: 10px;
}
</style>
</head>
<body>
	<div id='' class='container'>
	   <input id='search' class='w1000' onkeyup='autoCal(this)' autofocus/>
	</div>
	<div id='commands' class='container'>
	</div>
	<div id='htmlShow' class="container border-red"></div>
    <div class="container">
       <select id='pattern' class="hide">
           <option value='span'>span</option>
           <option value='pre'>pre</option>
       </select>
       <input id="category_name" class="" style="" placeholder="类目">
       <input id="title" class="" style="" placeholder="标题">
       <br>
       <textarea id='content' class="w99h200"></textarea>
    </div>	
	<div class='hide'>
		<div class='show ib border plt10' style="white-space: pre;display: inline-block !important;border-color: tan;margin-right: 10px;">
		  <p></p>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	getAll();
})
function save() {
	var pattern = $('#pattern').val();
	var category_name = $('#category_name').val();
	var title = $('#title').val();
	var content = $('#content').val();
    event.preventDefault();
    var json = {}
    json.pattern = $("#pattern").val();
    json.category_name = $("#category_name").val();
    json.title = $("#title").val();
    json.content= $("#content").val();
    var jsonStr = JSON.stringify(json);
    $.ajax({
        url : "<%=basePath%>command/save",
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
function getAll() {
    $.ajax({
        url:'<%=basePath%>command/getAll',
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
                    var command = json[i];
                    var cat = command.category_name;
                    if(!exist[cat]) {
                    	$('#commands').append("<h1>"+cat+"</h1>");
                    	exist[cat] = cat;
                    }
                    var content = command.content;
                    var text = command.content.replace(/\[\[.*?\]\]/gm, "<INPUT class='w100'/>")
                        .replace(/<(?!INPUT)/gm,'&lt;')
                        .replace(/>(?<!INPUT)>/gm,'&gt;')
                        ;
                    var clone = $('.hide .show').clone(true);
                    clone.html(text);
                    clone.attr('id', command.id);
                    clone.attr('content', content);
                    clone.attr('category_name', command.category_name);
                    clone.attr('title', command.title);
                    $('#commands').append(clone);
                    clone.before("<p style='color:red;border-color: tan;margin-left:10px;vertical-align:middle;' class='ib border'>"+command.title+"</p>");
                    // 有input时blur时自动生成命令
                    clone.find('input').bind('blur', function(){
                    	calc(this);
                    })
                    // 无input时点击直接复制
                    if(!content.match(/\[\[.*\]\]/)) { 
	                    clone.click(function(){
	                    	var text = $(this).text();
	                    	copy(text);
	                    })
                    }
                }
                bindDel();
            }
        }
    }); 
}
function bindDel() {
	$(".show").bind("contextmenu", function(){
	    event.preventDefault();
	    var id = $(this).attr('id');
	    $.ajax({
	        url : "<%=basePath%>command/remove/"+id,
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
}
function calc(input) {
	var show = $(input).parent();
	var content = show.attr('content');
	var inputs = show.find('input');
	for(var i=0;i<inputs.length;i++) {
		content = content.replace(/\[\[.*?\]\]/, $(inputs[i]).val());
	}
	copy(content);
	if(show.attr('category_name') == 'html') {
		$('#htmlShow').empty().html(content);
	}
}
function autoCal(obj) {
	var keyword = $(obj).val();
	var split = keyword.split(' '); // [for arr arr]
	var like = split[0];
	$("#commands p").each(function() {
		var title = $(this).text();
		var reg = eval("/"+like+"/g");
		if(!reg.test(title)) {
			$(this).next().remove();
			$(this).remove();
		}
	});
	// 自动填充input 
	var inputs = $('.show input');
	if(split.length>1) {
		for(var i=1;i<split.length;i++) {
			var val = split[i];
			var index = i-1;
			if(val) {
				$(inputs[index]).val(val);	
				if(i == inputs.length) {
					calc(inputs[index]);
					$("#search").focus();
				}
			}
		}
	}
}
</script>
</html>
