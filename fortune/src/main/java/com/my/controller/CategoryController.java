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

import com.my.api.ICategoryService;
import com.my.entity.Category;
import com.my.util.Result;
import com.my.util.ResultConstant;

/**
 * 类目Controller
 */
@Controller
@RequestMapping("/category")
public class CategoryController extends BaseController{
	
	private Logger logger = LoggerFactory.getLogger(CategoryController.class);

	@Resource
	private ICategoryService iCategoryService;
	
	/**
	 * 新增类目
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
    @ResponseBody
    public Result save(@RequestBody Category category) throws Exception {
        iCategoryService.save(category);
        return ResultConstant.Success;
    }	
	
	/**
	 * 修改类目
	 */
	@RequestMapping(value="/update",method=RequestMethod.PUT)
    @ResponseBody
    public Result update(@RequestBody Category vo) throws Exception {
		// 更新类目
		Category category = iCategoryService.getById(vo.getId());
		category.setLevel(vo.getLevel());
		category.setName(vo.getName());
		category.setDescription(vo.getDescription());
        iCategoryService.save(category);
        return ResultConstant.Success;
    }	
    
	/**
	 * 查询类目
	 */
	@RequestMapping(value="/getById",method=RequestMethod.GET)
    @ResponseBody
    public Category getById(@RequestParam("id") Integer id) throws Exception { 
        return iCategoryService.getById(id);
    }
	
	/**
	 * 查询所有类目
	 */
	@RequestMapping(value="/getAll",method=RequestMethod.GET)
	@ResponseBody
	public List<Category> getAll() throws Exception { 
		return iCategoryService.getAll();
	}

	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}
	
}
