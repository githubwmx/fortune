<%
    String path_EasyUI = request.getContextPath();
    String basePath_EasyUI = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path_EasyUI+"/";
%>

<link rel="stylesheet" type="text/css" href="<%=basePath_EasyUI %>jquery-easyui-1.5.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath_EasyUI %>jquery-easyui-1.5.3/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath_EasyUI %>jquery-easyui-1.5.3/demo/demo.css">

<script type="text/javascript" src="<%=basePath_EasyUI %>jquery-easyui-1.5.3/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath_EasyUI %>jquery-easyui-1.5.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath_EasyUI %>jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript" src="<%=basePath_EasyUI %>jquery-easyui-1.5.3/plugins/jquery.form.js"></script>
<script type="text/javascript" src="<%=basePath_EasyUI %>jquery-easyui-1.5.3/plugins/jquery.validatebox.js"></script>
