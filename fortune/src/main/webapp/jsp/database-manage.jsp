<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include-base.jsp"%>
<%@ include file="include-bootstrap.jsp"%>		
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据库</title>
<style>
.container {
	width: 90% !important;
}
</style>
</head>
<body>
<div id="control" class="container">
    <select id="databases" name="">
        <option value='jdbc:mysql://127.0.0.1:3306/fortune' username='root' password='root'>127.0.0.1 fortune</option>
    </select>    
    <button id="" class="btn btn-default" onclick="loadConfig()">加载配置</button>
    <hr/>
    <button id="gene" class="btn btn-default" onclick="gene()">生成查询</button>
    <select class='tables' onchange="getColumns(this)">
        <option></option>
    </select>    
    <select class='columns'>
        <option></option>
    </select>    
    <div class='checkboxs'></div>    
    <div class='sqlResult p10'></div>    
    <div class='updateSqlResult p10'></div>    
    <div class='searchResult p10'>
        <table class='lay1' id='articletodo'></table>
    </div>    
</div>
</body>
<script type="text/javascript">
$(function(){
	loadAllTablesByDatabase();
});
function loadAllTablesByDatabase() {
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
	        for(var i=0;i<json.length;i++) {
	            var obj = json[i];
	            $(".tables").append("<option id='"+obj.id+"' value='"+obj.table_name+"'>"+obj.table_comment+"</option>");               
	        }
// 	        $(".tables:first").change(); todo
            $(".tables").val('articletodo');
            $(".tables").trigger('change');
	    }
	});	
}
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
                // 选择主键的select
                $(this_).next().append("<option id='"+obj.id+"' value='"+obj.column_+"'>"+(obj.column_+"【"+obj.comment_+"】")+"</option>");      
                // 把列以checkbox的形式显示出来 
                var checkboxs = $(this_).next().next();
                var html = "<div style='word-break: break-all;margin-top:5px;margin-right:5px;' class='ib w200 border p10' onclick='$($(this).children()[0]).click()'>"
		                            +"<input type='checkbox' id='"+obj.column_+"' style='margin-left:5px;'/>"
					                + "<span>" + obj.column_ + "</span>"
					                + "<input type='input' class='w100'/><br>"+obj.comment_
					      +"</div>";
                $(checkboxs).append(html);
            }
        }
    }); 
}
function loadConfig() {
	var opt = $('#databases option:selected');
	var url = opt.val();
	var username = opt.attr('username');
	var password = opt.attr('password');
    $.ajax({
        url:'<%=basePath%>databaseManage/loadConfig',
        data:{
        	"url":url,
        	"username":username,
        	"password":password
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
function getSelectTable() {
	return $(".tables").val();
}
function gene() {
	var sql = " select * from " + getSelectTable() + " where 1=1 ";
    var chs = $('.checkboxs :checkbox');
    for(var i=0;i<chs.length;i++) {
        var ch = $(chs[i]);
        var column = $(ch).attr('id');
        var val = ch.next().next().val();
        if(val) {
        	sql += " and " + column + "='"+val+"' ";
        }
    }
    $('.sqlResult').empty().append(sql);
    execQueryAndDisplay(sql, chs);
}
function execQueryAndDisplay(sql, chs) {
	var sqlColumns = '';
    // 展示
    var html = "<tr>";
    for(var i=0;i<chs.length;i++) {
        var ch = $(chs[i]);
        html += "<td>" + ch.attr('id') + "</td>";
        if(!sqlColumns) {
        	sqlColumns += ch.attr('id');
        } else {
        	sqlColumns += ',' + ch.attr('id');
        }
    }
    html += "</tr>";
    sql = sql.replace('*',sqlColumns);
    $('.sqlResult').empty().append(sql);
    $('.lay1').empty().append(html);
    // 查询结果
    $.ajax({
        url:'<%=basePath%>databaseManage/execQuery',
        data:{
            "sql":sql.replace('todo','')
        },
        type : 'get',
        dataType : 'json',
        contentType: "application/json; charset=utf-8",
        async : false,
        cache : false,
        success:function(json){
            var trHtml = '<tr>';
            for(var i=0;i<json.length;i++) {
            	trHtml+="<td><input onchange='recordChange(this)' value='"+json[i]+"'/></td>";
            }
            trHtml += '</tr>';
        	$('.lay1').append(trHtml);
        	recurLoadRel(getSelectTable(),2);
        }
    });     
}
function execQuery(sql) {
	var result;
    $.ajax({
        url:'<%=basePath%>databaseManage/execQuery2',
        data:{
            "sql":sql.replace('todo','')
        },
        type : 'get',
        dataType : 'json',
        contentType: "application/json; charset=utf-8",
        async : false,
        cache : false,
        success:function(json){
            result = json;
        }
    });     	
    return result;
}
var relMap = {
        'articletodo':'test1',
        'test1':'test2'
}
// 递归加载外键关联的表
function recurLoadRel(tableName,deep) {
	debugger;
	var relTable = relMap[tableName];
	if(!relTable) {
		return;
	}
	var trs = $("#"+tableName).find("tr");
	// 每一行都要向下加载
	if(trs.length>=1) {
		for(var i=1;i<trs.length;i++) {
			var tr = $(trs[i]); // 主表的数据行
			var id = tr.find('td:eq(0) input').val(); // 主表一行的id
			sql = " select id,name from " + relTable.replace('todo','') + " where 1=1 and " + tableName + "_id = " + id;
			var json = execQuery(sql);
		    var margin = deep*20;
			var html = '<tr><td colspan="100"><table id="'+relTable+'" style="margin-left:'+margin+'px">'; // 创建一个下级table
			html+="<tr><td>id</td><td>name</td></tr>";
			for(var j=0;j<json.length;j++) {
				if(j%2==0) { // 后台只返回了2个字段,2个字段一行
					html+="<tr><td><input value='"+json[j]+"'></input></td><td><input value='"+json[j+1]+"'></input></td></tr>";
				}
			}
			html+='</table></td></tr>';
			tr.after(html);
			recurLoadRel(relTable, deep+1);
		}
	}
}
function recordChange(tdInput) {
	var input = $(tdInput);
	input.attr('changed','1');
	geneUpdate(input);
}
function geneUpdate(input) {
	var sql = " update " + getSelectTable() + " set "
	var rowInputs = input.parent().parent().find('input');
	var changedInputs = {};
	for(var i=0;i<rowInputs.length;i++) {
		if($(rowInputs[i]).attr('changed') == 1) {
			var inpu = rowInputs[i];
			var th = input.parent().parent().parent().find('tr:eq(0)').find("td:eq("+i+")");
			var column = th.text();
			var set = column + " = '"+$(inpu).val()+"' ";
			if(sql.endsWith("set ")) {
			    sql +=  set;			  
			} else {
				sql += "," + set;
			}
		}
	}
	sql += " where id = " + $(".lay1 tr:eq(1) td:eq(0) input").val();
	$(".updateSqlResult").empty().append(sql);
}
</script>
</html>
