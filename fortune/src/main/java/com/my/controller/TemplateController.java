package com.my.controller;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.api.ITemplateService;
import com.my.entity.Template;
import com.my.util.Result;
import com.my.util.ResultConstant;

/**
 * 模板Controller
 */
@Controller
@RequestMapping("/template")
public class TemplateController extends BaseController{
	
	private Logger logger = LoggerFactory.getLogger(TemplateController.class);

	@Resource
	private ITemplateService iTemplateService;
	
	/**
	 * 新增模板
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
    @ResponseBody
    public Result save(@RequestBody Template template) throws Exception {
		iTemplateService.deleteByName(template.getName());
        iTemplateService.save(template);
        return ResultConstant.Success;
    }	
	
	/**
	 * 修改模板
	 */
	@RequestMapping(value="/update",method=RequestMethod.PUT)
    @ResponseBody
    public Result update(@RequestBody Template vo) throws Exception {
		// 更新模板
		Template template = iTemplateService.getById(vo.getId());
		template.setName(vo.getName());
		template.setContent(vo.getContent());
        iTemplateService.save(template);
        return ResultConstant.Success;
    }	
    
	/**
	 * 查询模板
	 */
	@RequestMapping(value="/getById",method=RequestMethod.GET)
    @ResponseBody
    public Template getById(@RequestParam("id") Integer id) throws Exception { 
        Template template = iTemplateService.getById(id);
		return template;
    }
	
	@RequestMapping(value="/getAll",method=RequestMethod.GET)
	@ResponseBody
	public List<Template> getById() throws Exception { 
		List<Template> all= iTemplateService.getAll();
		return all;
	}
	
	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}
	
}
