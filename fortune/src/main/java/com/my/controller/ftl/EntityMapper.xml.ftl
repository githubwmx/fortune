<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.dzjt.dzjtpreclearbiz.biz.mapper.${module.class_name}Mapper">
  <resultMap id="BaseResultMap" type="com.dzjt.dzjtpreclearbiz.biz.model.${module.class_name}">
    <id column="ID" jdbcType="BIGINT" property="id"/>
<#if slaves?exists> 
	<#list 0..module.columns?size-1 as i> 
	    <result column="${module.columns[i].column_}" jdbcType="${module.columns[i].mybatis_type}" property="${module.columns[i].name}"/>
	</#list>		
</#if>    
  </resultMap>
  
  <!-- 分页查询 -->
  <select id="select${module.class_name}List" resultType="com.dzjt.dzjtpreclearbiz.biz.vo.carmanageVo.${module.class_name}ListVo"
          parameterType="com.dzjt.dzjtpreclearbiz.biz.vo.marketVo.MarketBudgetQueryVo">
    SELECT
    t2.user_name submittedByName,
    t3.org_name companyName,
<#list 0..module.columns?size-1 as i> 
    t.${module.columns[i].column_} ${module.columns[i].name}<#if i!=module.columns?size-1 >,</#if>
</#list>		
    FROM
    ${module.table_name} t
    left join dzjt_official_car.BASE_ORG_USER_BINDING t2 on t2.ID = t.SUBMITTED_BY
    left join dzjt_official_car.BASE_ORG t3 on t3.id = t.COMPANY_ID
    WHERE t.IS_DELETE = 1
    <if test="queryVo.companyId!=null and queryVo.companyId!='' ">
      AND t.COMPANY_ID = ${r"#{"}queryVo.companyId${r"}"}
    </if>

    <if test="queryVo.budgetYear!=null and queryVo.budgetYear!=''">
      AND t.BUDGET_YEAR = ${r"#{"}queryVo.budgetYear${r"}"}
    </if>

    <if test="queryVo.budgetStatus!=null and queryVo.budgetStatus!=''">
      AND t.BUDGET_STATUS = ${r"#{"}queryVo.budgetStatus${r"}"}
    </if>
    <if test="queryVo.numberNo!=null  and queryVo.numberNo!='' ">
      AND t.NUMBER_NO = ${r"#{"}queryVo.numberNo${r"}"}
    </if>
  </select>

  <!-- 查询基本信息 -->
  <select id="select${module.class_name}Return" resultType="com.dzjt.dzjtpreclearbiz.biz.vo.carmanageVo.${module.class_name}ReturnVo" parameterType="Long">
    SELECT
    t2.user_name submittedByName,
    t3.org_name companyName,
<#if slaves?exists> 
	<#list 0..module.columns?size-1 as i> 
    t.${module.columns[i].column_} ${module.columns[i].name}<#if i!=module.columns?size-1 >,</#if>
	</#list>		
</#if>        
    FROM
    ${module.table_name} t
    left join dzjt_official_car.BASE_ORG_USER_BINDING t2 on t2.ID = t.SUBMITTED_BY
    left join dzjt_official_car.BASE_ORG t3 on t3.id = t.COMPANY_ID
    WHERE t.IS_DELETE = 1 and t.ID = ${r"#{"}id${r"}"}
  </select>

<#if slaves?exists> 
	<#list 0..slaves?size-1 as i> 
  <!-- 根据id查询详情 -->
  <select id="select${slaves[i].class_name}VoListById" resultType="com.dzjt.dzjtpreclearbiz.biz.vo.carmanageVo.${slaves[i].class_name}Vo" parameterType="Long">
    SELECT
<#if slaves[i].columns?exists> 
	<#list 0..slaves[i].columns?size-1 as j> 
    t.${slaves[i].columns[j].column_} ${slaves[i].columns[j].name}<#if i!=slaves[i].columns?size-1 >,</#if>
	</#list>		
</#if>      
    FROM
      ${slaves[i].table_name}
    WHERE IS_DELETE =1 and ${module.table_name}_ID = ${r"#{"}id${r"}"}
  </select>
	</#list>		
</#if>

  <update id="delete${module.class_name}" parameterType="Long">
    update ${module.table_name} set IS_DELETE = 0 WHERE ID = ${r"#{"}id}
  </update>

  <select id="getMaxNumber" resultType="String">
    select max(number_no) from ${module.table_name}
  </select>

</mapper>