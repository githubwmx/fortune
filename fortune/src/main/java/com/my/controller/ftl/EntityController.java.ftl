package com.dzjt.dzjtpreclearbiz.biz.controller;

import com.alibaba.fastjson.JSON;
import com.dzjt.core.constant.Constants;
import com.dzjt.core.exception.BizException;
import com.dzjt.core.response.R;
import com.dzjt.core.support.Grid;
import com.dzjt.dzjtpreclearbiz.biz.model.${module.class_name};
import com.dzjt.dzjtpreclearbiz.biz.service.${module.class_name}Service;
import com.dzjt.dzjtpreclearbiz.biz.vo.issue.${module.class_name}ParamVo;
import com.dzjt.dzjtpreclearbiz.biz.vo.issue.${module.class_name}ReturnVo;
import com.dzjt.dzjtpreclearbiz.biz.vo.marketVo.MarketBudgetQueryVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * ${module.table_comment}管理
 * @author ch
 */

@Slf4j
@RestController
@RequestMapping("${module.entity_name}")
@Api(value = "/${module.entity_name}", tags = {"${module.class_name} API"}, description = "${module.table_comment} API")
public class ${module.class_name}Controller {

    @Autowired
    private ${module.class_name}Service ${module.entity_name}Service;

    /**
     * 生成${module.table_comment}编号
     * @return R
     */
    @GetMapping("getNumber")
    @ApiOperation(notes = "生成${module.table_comment}编号",
            httpMethod = Constants.GET,
            response = R.class,
            value = "生成${module.table_comment}编号",
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE,
            consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public R getNumber(){
        return R.of(${module.entity_name}Service.getNumber());
    }

    /**
     * 查询${module.table_comment}列表
     *
     * @param queryVo 入参查询
     * @return R
     */
    @PostMapping("select${module.class_name}")
    @ApiOperation(notes = "查询${module.table_comment}列表",
            httpMethod = Constants.POST,
            response = Grid.class,
            value = "查询${module.table_comment}列表",
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE,
            consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Grid select${module.class_name}(@RequestBody MarketBudgetQueryVo queryVo){
        log.info("${module.entity_name}Vo ===> {}",JSON.toJSONString(queryVo));
        return Grid.of(${module.entity_name}Service.select${module.class_name}List(queryVo, true));
    }

    /**
     * 保存${module.table_comment}
     *
     * @param paramVo 入参
     * @return R
     */
    @PostMapping("save")
    @ApiOperation(notes = "保存${module.table_comment}",
            httpMethod = Constants.POST,
            response = R.class,
            value = "保存${module.table_comment}",
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE,
            consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public R save${module.class_name}(@Validated(${module.class_name}.Save${module.class_name}.class) @RequestBody
                                                ${module.class_name}ParamVo paramVo) throws BizException {
        String s = ${module.entity_name}Service.insert${module.class_name}(paramVo.get${module.class_name}(), <#if slaves?exists> <#list 0..slaves?size-1 as index_> paramVo.get${slaves[index_].class_name}List()<#if index_!=slaves?size-1 >,</#if> </#list> </#if>);
        return R.of(s);
    }

    /**
     * 更新${module.table_comment}
     *
     * @param paramVo 入参
     * @return R
     */
    @PutMapping("update")
    @ApiOperation(notes = "更新${module.table_comment}",
            httpMethod = Constants.PUT,
            response = R.class,
            value = "更新${module.table_comment}",
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE,
            consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public R update${module.class_name}(@RequestBody @Validated(${module.class_name}.Update${module.class_name}.class)
                                        ${module.class_name}ParamVo paramVo) throws BizException {
           String s = ${module.entity_name}Service.update${module.class_name}(paramVo.get${module.class_name}(), <#if slaves?exists> <#list 0..slaves?size-1 as index_> paramVo.get${slaves[index_].class_name}List()<#if index_!=slaves?size-1 >,</#if> </#list> </#if>);
           return R.of(s);
    }

    /**
     * 逻辑删除${module.table_comment}
     *
     * @param id 入参ID
     * @return R
     */
    @DeleteMapping("delete/{id}")
    @ApiOperation(notes = "逻辑删除${module.table_comment}",
            httpMethod = Constants.DELETE,
            response = R.class,
            value = "逻辑删除${module.table_comment}",
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE,
            consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public R delete${module.class_name}(@PathVariable("id") Long id) {
        return R.of(${module.entity_name}Service.delete${module.class_name}(id));
    }

    /**
     * 根据ID获取${module.table_comment}
     *
     * @param id 入参ID
     * @return R
     */
    @GetMapping("get/{id}")
    @ApiOperation(notes = "根据ID获取${module.table_comment}",
            httpMethod = Constants.GET,
            response = R.class,
            value = "根据id获取${module.table_comment}",
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE,
            consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public R get${module.class_name}(@PathVariable("id") Long id){
        ${module.class_name}ReturnVo returnVo = ${module.entity_name}Service.select${module.class_name}Return(id);
        return R.of(returnVo);
    }

}
