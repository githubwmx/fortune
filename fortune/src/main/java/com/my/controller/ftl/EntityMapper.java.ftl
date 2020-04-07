package com.dzjt.dzjtpreclearbiz.biz.mapper;

/**
 * @author ch
 */
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dzjt.dzjtpreclearbiz.biz.model.${module.class_name};
import com.dzjt.dzjtpreclearbiz.biz.vo.carmanageVo.${module.class_name}ListVo;
import com.dzjt.dzjtpreclearbiz.biz.vo.carmanageVo.${module.class_name}ReturnVo;
import com.dzjt.dzjtpreclearbiz.biz.vo.marketVo.MarketBudgetQueryVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ${module.class_name}Mapper extends BaseMapper<${module.class_name}> {

        /**
         * @param queryVo
         * @return
         */
        IPage<${module.class_name}ListVo > select${module.class_name}List(Page page, @Param("queryVo")MarketBudgetQueryVo queryVo);
        
<#if slaves?exists> 
	<#list 0..slaves?size-1 as i> 
		<#assign slave=slaves[i] />
        /**
         * @param id
         * @return
         */
        List<${slave.class_name}Vo> select${slave.class_name}VoListById(Long id);
		<#if i!=slaves?size-1 >,</#if>
	</#list> 
</#if>
        
        /**
         * @param budget${module.class_name}
         * @return
         */
        Boolean save${module.class_name}(${module.class_name} budget${module.class_name});

        /**
         * @param id
         * @return
         */
        int delete${module.class_name}(Long id);

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

        String getMaxNumber();

}