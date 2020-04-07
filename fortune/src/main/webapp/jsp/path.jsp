<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include-base.jsp"%>
<%@ include file="include-bootstrap.jsp"%>		
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>路径</title>
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
#result div {
    padding: 5px !important;
    border:1px solid lightgray;
}
</style>
</head>
<body>
	<div class="container" id='labels'>
		<textarea style="width: 100%;height: 200px;" onblur="calc()"></textarea>
		<br/><br/>
		<div id='result'></div>
	</div>
</body>
<script type="text/javascript">
	function calc() {
		$("#result").empty();
		var val = $("textarea").val();
		var rawArray = val.split("\n");
		console.log(rawArray);
		if(val.indexOf("/") != -1) {
			convert('\\/', rawArray);
		} else if(val.indexOf("\\") != -1) {
			convert('\\\\', rawArray);
		}
		bindCopy();
	}
	function convert(splitChar, rawArray) {
		var needReplace = eval("/"+splitChar+"/g");
        // 转为/形式
        for(var i=0;i<rawArray.length;i++) {
            var val = rawArray[i];
            if(val) {
                val = val.replace(needReplace, '/');
                $("#result").append("<div>"+val+"</div>");  
            }
        }
        $("#result").append("<br/><br/>");
        // 转为\\形式
        for(var i=0;i<rawArray.length;i++) {
            var val = rawArray[i];
            if(val) {
                val = val.replace(needReplace, '\\\\');
                $("#result").append("<div>"+val+"</div>"); 
            }
        }
        $("#result").append("<br/><br/>");          
        // 转为git形式
        for(var i=0;i<rawArray.length;i++) {
            var val = rawArray[i];
            if(val) {
                val = '/' + val.replace(needReplace, '/').replace(':','');
                $("#result").append("<div>"+val+"</div>"); 
            }
        }		
	}
	function bindCopy() {
		$("#result div").one('click',function(){
			copy($(this).text());
		});
	}
</script>
</html>