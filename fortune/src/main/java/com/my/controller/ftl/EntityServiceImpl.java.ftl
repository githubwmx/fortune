package com.dzjt.dzjtpreclearbiz.biz.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dzjt.core.exception.BizException;
import com.dzjt.core.redis.service.RedisService;
import com.dzjt.core.response.ResponseType;
import com.dzjt.core.service.LogService;
import com.dzjt.core.support.BizType;
import com.dzjt.core.support.OptionType;
import com.dzjt.core.support.Payload;
import com.dzjt.core.support.Sort;
import com.dzjt.dzjtpreclearbiz.biz.mapper.${module.class_name}Mapper;
import com.dzjt.dzjtpreclearbiz.biz.model.${module.class_name};
<#if slaves?exists> 
	<#list 0..slaves?size-1 as i>
	<#assign slave=slaves[i] />
import com.dzjt.dzjtpreclearbiz.biz.model.${slave.class_name};
	</#list>		
</#if>    
<#if slaves?exists> 
	<#list 0..slaves?size-1 as i>
	<#assign slave=slaves[i] />
import com.dzjt.dzjtpreclearbiz.biz.vo.issue.${slave.class_name}Vo;
	</#list>		
</#if>    
import com.dzjt.dzjtpreclearbiz.biz.service.*;
import com.dzjt.dzjtpreclearbiz.biz.service.${module.class_name}Service;
import com.dzjt.dzjtpreclearbiz.biz.vo.ResourceFileLibraryVo;
import com.dzjt.dzjtpreclearbiz.biz.vo.carmanageVo.${module.class_name}ListVo;
import com.dzjt.dzjtpreclearbiz.biz.vo.carmanageVo.${module.class_name}ReturnVo;
import com.dzjt.dzjtpreclearbiz.biz.vo.marketVo.MarketBudgetQueryVo;
import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * ${module.table_comment}管理
 * @author ch
 */

@Slf4j
@Service
public class ${module.class_name}ServiceImpl extends ServiceImpl<${module.class_name}Mapper, ${module.class_name}> implements ${module.class_name}Service {

    @Autowired
    private LogService logService;
    @Autowired
    private RedisService redisService;
    @Autowired
    private ResourceFileLibraryService libraryService;
    @Autowired
    private ${module.class_name}Mapper mapper;
<#if slaves?exists> 
	<#list 0..slaves?size-1 as i>
	<#assign slave=slaves[i] />
    @Autowired
    private ${slave.class_name}Service ${slave.entity_name}Service;
	</#list>		
</#if>    

    @Override
    public IPage<${module.class_name}ListVo> select${module.class_name}List(MarketBudgetQueryVo queryVo,boolean isPage) {
        Page page = new Page();
        Sort.bind(queryVo,page);
        IPage<${module.class_name}ListVo> voPage = mapper.select${module.class_name}List(page, queryVo);
        return voPage;
    }

    @Override
    public Boolean save${module.class_name}(${module.class_name} ${module.entity_name}) {
        return null;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public String insert${module.class_name}(${module.class_name} ${module.entity_name}, <#if slaves?exists> <#list 0..slaves?size-1 as i> <#if slave.relation=='1:N'> List${r"<"}${slaves[i].class_name}${r">"} ${slaves[i].entity_name}List <#if i!=slaves?size-1 >,</#if> </#if> </#list> </#if>) throws BizException {
        Date date = new Date();
        Long userId = redisService.getCurrentUser().getUserId();
        final String userName = redisService.getCurrentUser().getUserName();
        ${module.entity_name}.setCreateBy(userId);
        ${module.entity_name}.setCreateByName(userName);
        ${module.entity_name}.setCreateDate(new Date());
        boolean a = this.save(${module.entity_name});
        boolean b = true;
<#if slaves?exists> 
	<#list 0..slaves?size-1 as i> 
		<#assign slave=slaves[i] />
        if(!CollectionUtils.isEmpty(${slave.entity_name}List)) {
            for (int i = 0; i<${slave.entity_name}List.size() ; i++) {
                ${slave.entity_name}List.get(i).set${module.class_name}Id(${module.entity_name}.getId());
                ${slave.entity_name}List.get(i).setCreateBy(userId);
                ${slave.entity_name}List.get(i).setCreateByName(userName);
                ${slave.entity_name}List.get(i).setCreateDate(new Date());
            }
            b = ${slave.entity_name}Service.saveBatch(${slave.entity_name}List);
        }
	</#list>		
</#if>            
        if (a && b && issue){
            return "添加成功！";
        }
        throw new BizException(ResponseType.BIZ_EXCEPTION.getStateCode(),"添加失败");
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public String update${module.class_name}(${module.class_name} ${module.entity_name}, <#if slaves?exists> <#list 0..slaves?size-1 as i> <#if slave.relation=='1:N'> List${r"<"}${slaves[i].class_name}${r">"} ${slaves[i].entity_name}List <#if i!=slaves?size-1 >,</#if> </#if> </#list> </#if>) throws BizException {
        //拿到主表ID
        Long id = ${module.entity_name}.getId();
        Date date = new Date();
        Long userId = redisService.getCurrentUser().getUserId();
        final String userName = redisService.getCurrentUser().getUserName();
        //根据主表ID拿到明细表相关记录
<#if slaves?exists> 
	<#list 0..slaves?size-1 as i> 
	<#assign slave=slaves[i] />
		List<${slave.class_name}Vo> ${slave.entity_name}VoList = mapper.select${slave.class_name}VoListById(id);
	</#list>		
</#if>           
        // 删除所有记录
        boolean success = true;
<#if slaves?exists> 
	<#list 0..slaves?size-1 as i> 
	<#assign slave=slaves[i] />
        if (${slave.entity_name}VoList!=null && ${slave.entity_name}VoList.size()>0){
            for (int i = 0; i < ${slave.entity_name}VoList.size(); i++) {
                String fileAdd = ${slave.entity_name}VoList.get(i).getFileAdd();
                if(StringUtils.isNotBlank(fileAdd)) {
                    if(!libraryService.removeById(fileAdd)) {
                        success = false;
                    }
                }
                if(!${slave.entity_name}Service.removeById(${slave.entity_name}VoList.get(i).getId())) {
                    success = false;
                }
            }
        }
	</#list>		
</#if>          
<#if slaves?exists> 
	<#list 0..slaves?size-1 as i>
	<#assign slave=slaves[i] />
        // 重新插入明细
        if(!CollectionUtils.isEmpty(${slave.entity_name}List)) {
            for (int i = 0; i<${slave.entity_name}List.size() ; i++) {
                ${slave.entity_name}List.get(i).set${module.class_name}Id(id);
                ${slave.entity_name}List.get(i).setUpdateBy(userId);
                ${slave.entity_name}List.get(i).setUpdateByName(userName);
                ${slave.entity_name}List.get(i).setUpdateDate(new Date());
                if(!${slave.entity_name}Service.saveBatch(${slave.entity_name}List)) {
                    success = false;
                }
            }
        }
	</#list>		
</#if>      
        ${module.entity_name}.setUpdateBy(userId);
        ${module.entity_name}.setUpdateByName(userName);
        ${module.entity_name}.setUpdateDate(date);
        if(!this.updateById(${module.entity_name})) {
            success = false;
        }
        if (success){
            return "修改成功！";
        }
        throw new BizException(ResponseType.BIZ_EXCEPTION.getStateCode(),"修改失败");
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public String delete${module.class_name}(@NonNull Long id) {
        int i = mapper.delete${module.class_name}(id);
        if (i>0){
            return "删除成功！";
        }
        return "删除成功！";
    }

    @Override
    public ${module.class_name} get${module.class_name}(@NonNull Long id){
        return this.getById(id);
    }

    @Override
    public ${module.class_name}ReturnVo select${module.class_name}Return(Long id) {
        ${module.class_name}ReturnVo ${module.entity_name}ReturnVo = mapper.select${module.class_name}Return(id);
<#if slaves?exists> 
	<#list 0..slaves?size-1 as i> 
	<#assign slave=slaves[i] />
		List<${slave.class_name}Vo> ${slave.entity_name}VoList = mapper.select${slave.class_name}VoListById(id);
	</#list>		
</#if>          
<#if slaves?exists> 
	<#list 0..slaves?size-1 as i> 
	<#assign slave=slaves[i] />
        if (${slave.entity_name}VoList!=null && ${slave.entity_name}VoList.size()>0){
            for (int i = 0; i < ${slave.entity_name}VoList.size(); i++) {
                String fileAdd = ${slave.entity_name}VoList.get(i).getFileAdd();
                List<ResourceFileLibraryVo> resourceFileLibraryList = libraryService.getResourceFileLibraryList(fileAdd);
                ${slave.entity_name}VoList.get(i).setFileLibraryVos(resourceFileLibraryList);
            }
            ${module.entity_name}ReturnVo.set${slave.class_name}VoList(${slave.entity_name}VoList);
        }
	</#list>		
</#if>          
        return ${module.entity_name}ReturnVo;
    }

    @Override
    public String getNumber() {
        String year = new SimpleDateFormat("yyyy").format(new Date());
        String maxNumber = mapper.getMaxNumber();
        if(StringUtils.isBlank(maxNumber)) {
            return "YS-"+year+"-08-001";
        } else {
            String[] split = maxNumber.split("-");
            if(year.equals(split[1])) {
                String s = "000"+(Integer.parseInt(split[3])+1);
                s = s.substring(s.length()-3,s.length());
                return "YS-"+year+"-08-"+s;
            } else {
                return "YS-"+year+"-08-001";
            }
        }
    }

}
