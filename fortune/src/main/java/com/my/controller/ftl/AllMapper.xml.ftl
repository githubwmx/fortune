<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.dzjt.dzjtpreclearbiz.biz.mapper.${module.class_name}Mapper">
  <resultMap id="BaseResultMap" type="com.dzjt.dzjtpreclearbiz.biz.model.${module.class_name}">
    <id column="ID" jdbcType="BIGINT" property="id"/>
<#if slaves?exists> 
	<#list 0..module.columns?size-1 as i> <#assign column=columns[i]> 
	    <result column="${column.column_}" jdbcType="${column.mybatis_type}" property="${column.name}"/>
	</#list>		
</#if>    
  </resultMap>
  
  <!-- 根据id查询 -->
  <select id="selectById" resultMap="BaseResultMap">
    select * from ${module.table_name} where id = ${r"#{"}id${r"}"}
  </select>

</mapper>