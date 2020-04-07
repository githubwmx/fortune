package com.dzjt.dzjtpreclearbiz.biz.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.dzjt.core.exception.BizException;
<#if slaves?exists> 
	<#list 0..slaves?size-1 as i>
	<#assign slave=slaves[i] />
import com.dzjt.dzjtpreclearbiz.biz.vo.issue.${slave.class_name}Vo;
	</#list>		
</#if>   
import com.dzjt.dzjtpreclearbiz.biz.model.${module.class_name};
import com.dzjt.dzjtpreclearbiz.biz.model.${module.class_name}Operations;
import com.dzjt.dzjtpreclearbiz.biz.model.${module.class_name}OtherDetails;
import com.dzjt.dzjtpreclearbiz.biz.vo.issue.${module.class_name}ReturnVo;
import com.dzjt.dzjtpreclearbiz.biz.vo.issue.${module.class_name}ListVo;
import com.dzjt.dzjtpreclearbiz.biz.vo.marketVo.MarketBudgetQueryVo;

import java.util.List;

/**
 * ${module.table_comment}管理
 * @author ch
 */
public interface ${module.class_name}Service extends IService<${module.class_name}> {

        /**
         * @param queryVo
         * @return
         */
        IPage<${module.class_name}ListVo > select${module.class_name}List(MarketBudgetQueryVo queryVo, boolean isPage);

        /**
         * @param budget${module.class_name}
         * @return
         */
        Boolean save${module.class_name}(${module.class_name} budget${module.class_name});

        /**
         * @param id
         * @return
         */
        String delete${module.class_name}(Long id);

        /**
         * 根据ID查询
         *
         * @param id
         * @return
         */
        ${module.class_name} get${module.class_name}(Long id);

        /**
         * 查询详情
         * @param id
         * @return
         */
        ${module.class_name}ReturnVo select${module.class_name}Return(Long id);

        String getNumber();

        String insert${module.class_name}(${module.class_name} budget${module.class_name}, <#if slaves?exists> <#list 0..slaves?size-1 as index_> <#if slaves[index_].relation=='1:N'> List${r"<"}${slaves[index_].class_name}${r">"} ${slaves[index_].entity_name}List <#if index_!=slaves?size-1 >,</#if> </#if> </#list> </#if>) throws  BizException;

        String update${module.class_name}(${module.class_name} budget${module.class_name}, <#if slaves?exists> <#list 0..slaves?size-1 as index_> <#if slaves[index_].relation=='1:N'> List${r"<"}${slaves[index_].class_name}${r">"} ${slaves[index_].entity_name}List <#if index_!=slaves?size-1 >,</#if> </#if> </#list> </#if>) throws BizException;

}
