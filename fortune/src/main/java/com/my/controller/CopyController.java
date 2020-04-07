package com.my.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.api.ICopyService;
import com.my.entity.Copy;
import com.my.util.Result;
import com.my.util.ResultConstant;

/**
 * 复制Controller
 */
@Controller
@RequestMapping("/copy")
public class CopyController extends BaseController{
	
	private Logger logger = LoggerFactory.getLogger(CopyController.class);

	@Resource
	private ICopyService iCopyService;
	
	/**
	 * 新增类目
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
    @ResponseBody
    public Result save(@RequestBody Copy copy) throws Exception {
        iCopyService.save(copy);
        return ResultConstant.Success;
    }	
	
	/**
	 * 修改类目
	 */
	@RequestMapping(value="/update",method=RequestMethod.PUT)
    @ResponseBody
    public Result update(@RequestBody Copy vo) throws Exception {
		// 更新类目
		Copy copy = iCopyService.getById(vo.getId());
		copy.setFormat(vo.getFormat());
		copy.setContent(vo.getContent());
        iCopyService.save(copy);
        return ResultConstant.Success;
    }	
    
	/**
	 * 查询类目
	 */
	@RequestMapping(value="/getById",method=RequestMethod.GET)
    @ResponseBody
    public Copy getById(@RequestParam("id") Integer id) throws Exception { 
        return iCopyService.getById(id);
    }
	
	/**
	 * 删除类目
	 */
	@RequestMapping(value="/remove/{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Result remove(@PathVariable("id") Integer id) throws Exception { 
		iCopyService.delete(id);
		return ResultConstant.Success;
	}
	
	/**
	 * 查询所有类目
	 */
	@RequestMapping(value="/getAll",method=RequestMethod.GET)
	@ResponseBody
	public List<Copy> getAll() throws Exception { 
		List<Copy> all = iCopyService.getAll();
		Collections.sort(all,new Comparator<Copy>() {
			@Override
			public int compare(Copy o1, Copy o2) {
				return o2.getFormat().compareTo(o1.getFormat());
			}
		});
		return all;
	}

	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}
	
}
