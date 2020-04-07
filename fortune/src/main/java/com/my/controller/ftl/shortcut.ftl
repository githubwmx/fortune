${module.class_name}
${module.entity_name}
${module.table_comment}


<#if slaves?exists> 
	<#list 0..slaves?size-1 as i>
	<#assign slave=slaves[i] />
		${slave.class_name}
		${slave.entity_name}
	</#list>		
</#if> 

<#if slaves?exists> 
	<#list 0..slaves?size-1 as i> 
		<#assign slave=slaves[i] />
		${slave.class_name}
		${slave.entity_name}		
		<#if i!=slaves?size-1 >,</#if>
	</#list> 
</#if>

<#if slaves?exists> 
	<#list 0..module.columns?size-1 as i> <#assign column=columns[i]> 
		${column.column_}
		${column.mybatis_type}
		${column.name}
	</#list>		
</#if>   