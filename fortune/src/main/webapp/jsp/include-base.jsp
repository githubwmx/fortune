<%@page import="java.util.*" %>

<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- jquery -->
<script type="text/javascript" src="<%=basePath %>js/jquery.min.js"></script>

<!-- my -->
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/common.css"/>
<script src="<%=basePath %>js/common.form.js"></script>
<script src="<%=basePath %>js/common.js"></script>
<script src="<%=basePath %>js/my.js"></script>
<script src="<%=basePath %>js/my.dev.js"></script>

<iframe name='hiddeniframe' style='display:none'></iframe>
