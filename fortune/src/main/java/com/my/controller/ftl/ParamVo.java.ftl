package com.dzjt.dzjtpreclearbiz.biz.vo;

import com.dzjt.core.support.PageVo;
import com.dzjt.dzjtpreclearbiz.biz.model.${module.class_name};
<#if slaves?exists> 
	<#list 0..slaves?size-1 as i>
		<#assign slave=slaves[i] />
import com.dzjt.dzjtpreclearbiz.biz.model.${slave.class_name};
	</#list> 
</#if>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

/**
 * @author wmx
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ApiModel(description = "${module.table_comment}新增入参")
public class ${module.class_name}ParamVo extends PageVo {

    @ApiModelProperty(value = "车辆管理决算表基本信息")
    private ${module.class_name} ${module.entity_name};
<#if slaves?exists> 
	<#list 0..slaves?size-1 as i>
		<#assign slave=slaves[i] />
    @ApiModelProperty(value = "${slave.table_comment}")
    private List<${slave.class_name}> ${slave.entity_name}List;
	</#list> 
</#if>

}
