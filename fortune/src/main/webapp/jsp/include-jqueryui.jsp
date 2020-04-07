<%@page import="java.util.*" %>

<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String path_jqueryui = request.getContextPath();
	String basePath_jqueryui = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path_jqueryui+"/";
%>
<!-- jquery -->
<script type="text/javascript" src="<%=basePath_jqueryui %>js/jquery.min.js"></script>

<!-- my -->
<script src="<%=basePath_jqueryui %>jquery-ui-1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath_jqueryui %>jquery-ui-1.12.1/jquery-ui.css"/>
