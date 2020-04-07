<%
	String path_Bootstrap = request.getContextPath();
	String basePath_Bootstrap = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path_Bootstrap+"/";
%>
<!-- jquery -->
<script type="text/javascript" src="<%=basePath_Bootstrap %>js/jquery.min.js"></script>

<!-- easyui -->
<link rel="stylesheet" type="text/css" href="<%=basePath_Bootstrap %>jquery-easyui-1.5.3/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath_Bootstrap %>jquery-easyui-1.5.3/themes/icon.css"/>
<script type="text/javascript" src="<%=basePath_Bootstrap %>jquery-easyui-1.5.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath_Bootstrap %>jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js"></script>

<!-- bootstrap -->
<link rel="stylesheet" type="text/css" href="<%=basePath_Bootstrap %>bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
<script src="<%=basePath_Bootstrap %>bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<!-- bootstrap laydate -->
<%-- <script src="<%=basePath_Bootstrap %>layDate-v5.0.9/laydate/laydate.js"></script> --%>

<!-- bootstrap select2 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>

<!-- bootstrapValidator -->
<link rel="stylesheet" type="text/css" href="<%=basePath_Bootstrap %>bootstrapvalidator-master/dist/css/bootstrapValidator.css"/>
<script src="<%=basePath_Bootstrap %>bootstrapvalidator-master/dist/js/bootstrapValidator.js"></script>
<script src="<%=basePath_Bootstrap %>bootstrapvalidator-master/dist/js/language/zh_CN.js"></script>

<!-- gentelella -->
<%-- <link href="<%=basePath_Bootstrap%>gentelella-master/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet"/> --%>

<!-- echarts -->
<script src="<%=basePath %>js/echarts.js"></script>
