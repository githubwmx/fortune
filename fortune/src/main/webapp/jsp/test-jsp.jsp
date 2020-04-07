<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include-base.jsp"%>
<%@ include file="include-bootstrap.jsp"%>
<body>
	<div class='container'>

<el-table :data="tableData" style="width: 100%">
<el-table-column prop="id" label="序号" width="180"> </el-table-column>
<el-table-column fixed="right" label="操作" width="150">
<template slot-scope="scope">
<el-button type="text" @click="open6(scope.row)" size="small">删除</el-button>
<el-button type="text" @click="open1(true,scope.row.id)" size="small">修改</el-button>
</template>
</el-table-column>
</el-table>

	</div>
</body>

<script type="text/javascript">
	
</script>