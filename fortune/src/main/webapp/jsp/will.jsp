<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>

<%@ include file="include-base.jsp"%>
<%@ include file="include-bootstrap.jsp"%>		

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.config.js"></script>
	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.all.js"></script>
	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.parse.js"></script>
	<script src="<%=basePath %>ueditor1_4_3_3-utf8-jsp/utf8-jsp/lang/zh-cn/zh-cn.js"></script>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>意志</title>

</head>
<body>

<sql:setDataSource dataSource="jdbc:mysql://127.0.0.1:3306/fortune" var="datasource"/>
<sql:query var="result" dataSource="${datasource}" maxRows="100" startRow="0">
    select name,start_time,end_time,
    DATEDIFF(end_time,start_time)+1 as all_days,
    DATEDIFF(now(),start_time) as now_days,
    DATEDIFF(now(),start_time)/(DATEDIFF(end_time,start_time)+1) raw_rate,
    CONCAT(DATEDIFF(now(),start_time)/(DATEDIFF(end_time,start_time)+1)*100,'%') as rate 
    from will
    order by raw_rate
    
</sql:query>
<div class="container" id="" name="">
<table width="100%" class='table'>
    <tr>
        <td>名称</td>
        <td>开始时间</td>
        <td>结束时间</td>
        <td>总天数</td>
        <td>已完成天数</td>
        <td>完成率</td>
    </tr>
    <c:forEach items="${result.rows}" var="row">
        <tr>
            <td>${row.name}</td>
            <td>${row.start_time}</td>
            <td>${row.end_time}</td>
            <td>${row.all_days}</td>
            <td>${row.now_days}</td>
            <td>${row.rate}</td>
        </tr>
    </c:forEach>
</table>
</div>    
</body>

</html>