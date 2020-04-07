<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include-base.jsp"%>
<%@ include file="include-bootstrap.jsp"%>		
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据库查询</title>
<style>
.container {
	padding: 10px;
	width: 90%;
}
.label {
	color: black;
	padding: 5 10px;
	margin: 5px;
	border: 1px solid gray;
	display: inline-block !important;
}
.labeltext {
	font-size: large;
	text-align: left;
	padding-left:50px;
}
#labels select {
	margin-top: 5px;
	line-height: 30px;
	height:30px;
}
.tables {
	text-align: left;
}
.checkboxs {
	font-size: 16px;
}
.checkboxs input[type=checkbox] {
	width:15px;
	height:15px;
}
</style>
</head>
<body>	
	<div class="container" id='labels' style="">
		<div class='table'>
			<select class='tables' onchange="getColumns(this)">
				<option></option>
			</select>
			<select class='columns'>
				<option></option>
			</select>
			<div class='checkboxs'></div>
		</div>			
	</div>
	<div class="container"
		<pre id='result'></pre>
	</div>
</body>
<script type="text/javascript">
for(var i=0;i<9;i++) {
	$('.container').append($(".table:eq(0)").clone());
}
// 加载所有表
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
    		$(".tables").append("<option id='"+obj.id+"' value='"+obj.table_name+"'>"+obj.table_comment+"</option>");	    		
    	}
    	$(".tables:first").change();
    }
});
// 查询一个表的所有列
function getColumns(this_) {
	var id = $(this_).find('option:selected').prop('id');
	$.ajax({
	    url : "<%=basePath%>module/getColumnsById/"+id,
	    type : 'GET',
	    dataType : 'json',
	    contentType: "application/json; charset=utf-8",  
	    async : false,
	    cache : false,
	    data : {},
	    success: function(json) {
	   		modules = obj;
	   		$(this_).next().empty();
	    	for(var i=0;i<json.length;i++) {
	    		var obj = json[i];
	    		$(this_).next().append("<option id='"+obj.id+"' value='"+obj.column_+"'>"+(obj.column_+"【"+obj.comment_+"】")+"</option>");	    
	    		// 把列以checkbox的形式显示出来 
	    		var checkboxs = $(this_).next().next();
	    		var html = "<div style='display:inline-block;margin-top:5px;margin-right:5px;border:none;' class='ib m10'><input type='checkbox' id='"+obj.column_+"' style='margin-left:5px;'/><span onclick='$(this).prev().click()'>"+obj.column_+"【"+obj.comment_+"】</span><input type='input' style='width:50px;border:none'/></div>";
	    		$(checkboxs).append(html);
	    		
	    	}
	    }
	});	
}
$('body').bind('keyup', function(event) {
    if (event.keyCode == "13") {
    	generate();
    }
});
// 生成sql
function generate() {
	var sql = '';
	var columnsSql = '';
	var from = '';
	var where = '';
	var tables = $('.tables');
	var columns = $('.columns');
	var tableNames = new Array();
	var joinColumns = new Array();
	// 抽取数据
	for(var i=0;i<tables.length;i++) {
		if($(tables[i]).val()) {
			tableNames.push($(tables[i]).val());
		}
	}
	for(var i=0;i<tableNames.length;i++) {
		joinColumns.push($(columns[i]).val());
	}
	// 组装from
	for(var i=0;i<tableNames.length;i++) {
		var tableName = tableNames[i].toUpperCase();
		var join = joinColumns[i];
		var flag = "t"+i;
		var flagPrev = "t"+(i-1);
		if(i==0) {
			from += "from " + tableName + " " + flag;
		} else {
			from += " left join " + tableName + " " + flag + " on " + flag + "." + join + " = " + flagPrev + "." + joinColumns[i-1];
		}	
	}
	// 组装column
	$(tables).each(function(index,ele){
		// 列
		var columns = $(ele).next().next().find('input[type="checkbox"]:checked');
		for(var i=0;i<columns.length;i++) {
			var column = $(columns[i]).prop('id');
			columnsSql += " t"+index+"."+column + " " + camel(column) +",\n";
		}
		// where条件
		var columns2 = $(ele).next().next().find('input[type="checkbox"]');
		for(var i=0;i<columns2.length;i++) {
			var column = $(columns2[i]).prop('id');
			var val = $(columns2[i]).next().next().val();
			if(val) {
				where += " and t"+index+"."+column + " = " + val;  		
			}
		}
	});
	columnsSql = columnsSql.substring(0,columnsSql.length-2) + " \n";
	// 组装完整sql
	sql = "select \n" + columnsSql + from + "\n" + "where 1=1 " + where;
	$('#result').html(sql);
}
function getSplit(i) {
	if(i==0) {
		return ",";
	} else {
		return "";
	}
}
function camel(str){
    var strArr=str.split('_');
    for(var i=1;i<strArr.length;i++){
        strArr[i]=strArr[i].charAt(0).toUpperCase()+strArr[i].substring(1);
    }
    return strArr.join('');
}
</script>
</html>