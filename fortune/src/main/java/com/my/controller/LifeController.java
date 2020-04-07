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

import com.my.api.ILifeService;
import com.my.entity.Life;
import com.my.util.Result;
import com.my.util.ResultConstant;

/**
 * 生活Controller
 */
@Controller
@RequestMapping("/life")
public class LifeController extends BaseController {
	
	private Logger logger = LoggerFactory.getLogger(LifeController.class);

	@Resource
	private ILifeService iLifeService;
	
	/**
	 * 新增生活
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
    @ResponseBody
    public Result save(@RequestBody Life life) throws Exception {
        iLifeService.save(life);
        return ResultConstant.Success;
    }	
	
	/**
	 * 修改生活
	 */
	@RequestMapping(value="/update",method=RequestMethod.PUT)
    @ResponseBody
    public Result update(@RequestBody Life vo) throws Exception {
		// 更新生活
		Life life = iLifeService.getById(vo.getId());
		life.setCategory_name(vo.getCategory_name());
		life.setTitle(vo.getTitle());
		life.setContent(vo.getContent());
		life.setIs_folder(vo.getIs_folder());
        iLifeService.save(life);
        return ResultConstant.Success;
    }	
    
	/**
	 * 查询生活
	 */
	@RequestMapping(value="/getById",method=RequestMethod.GET)
    @ResponseBody
    public Life getById(@RequestParam("id") Integer id) throws Exception { 
        Life life = iLifeService.getById(id);
        int count = life.getCount();
        count++;
        life.setCount(count);
        iLifeService.update(life);
		return life;
    }
	
	/**
	 *  打开文件夹
	 * @return 
	 */
	@RequestMapping(value="/openFolder",method=RequestMethod.GET)
	@ResponseBody
	public Result openFolder(@RequestParam("id") Integer id) throws Exception { 
		Life life = iLifeService.getById(id);
		String path = life.getContent().replaceAll("<p>", "").replaceAll("</p>", "");
		Runtime.getRuntime().exec("cmd /k explorer " + path);
		return ResultConstant.Success; 
	}
	
	/**
	 * 模糊搜索
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/search",method=RequestMethod.GET)
	@ResponseBody
	public List<Life> getById(@RequestParam("keyword") String keyword) throws Exception { 
		List<Life> list= iLifeService.getByKeyword(keyword);
		return list;
	}
	
	@RequestMapping(value="/getByCategory",method=RequestMethod.GET)
    @ResponseBody
    public List<Life> getByCategory(@RequestParam("name") String name) throws Exception { 
        return iLifeService.getByCategory(name);
    }
	
	/**
	 * 查询生活
	 */
	@RequestMapping(value="/getAllTitle",method=RequestMethod.GET)
	@ResponseBody
	public List<Life> getById() throws Exception { 
		return iLifeService.getAllTitle();
	}
	
	@RequestMapping(value="/getAllCategory",method=RequestMethod.GET)
	@ResponseBody
	public List<Object[]> getAllCategory() throws Exception {
		List<Object[]> allCategory = iLifeService.getAllCategory();
		return allCategory;
	}
	
	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}
	
}
