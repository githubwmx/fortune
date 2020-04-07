【缺失属性】
    @ApiModelProperty(value = "主键id", example = "0", required = true)
    private Long id;
    @ApiModelProperty(value = "公司名称", example = "0", required = true)
    private String companyName;
    @ApiModelProperty(value = "提交人名称", example = "0")
    private String submittedByName;

    @ApiModelProperty(value = "文件列表")
    List<ResourceFileLibraryVo> fileLibraryVos;

【ReturnVo】
复制基本的Vo对象里面的所有属性

<#if slaves?exists> 
	<#list 0..slaves?size-1 as i>
		<#assign slave=slaves[i] />
    @ApiModelProperty(value = "${slave.table_comment}")
    private List<${slave.class_name}Vo> ${slave.class_name}VoList;
	</#list> 
</#if>
    