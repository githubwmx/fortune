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

import com.my.api.ICommandService;
import com.my.entity.Command;
import com.my.util.Result;
import com.my.util.ResultConstant;

/**
 * 命令Controller
 */
@Controller
@RequestMapping("/command")
public class CommandController extends BaseController {
	
	private Logger logger = LoggerFactory.getLogger(CommandController.class);

	@Resource
	private ICommandService iCommandService;
	
	/**
	 * 新增命令
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
    @ResponseBody
    public Result save(@RequestBody Command command) throws Exception {
        iCommandService.save(command);
        return ResultConstant.Success;
    }	
	
	/**
	 * 修改命令
	 */
	@RequestMapping(value="/update",method=RequestMethod.PUT)
    @ResponseBody
    public Result update(@RequestBody Command vo) throws Exception {
		// 更新命令
		Command command = iCommandService.getById(vo.getId());
		command.setPattern(vo.getPattern());
		command.setCategory_name(vo.getCategory_name());
		command.setTitle(vo.getTitle());
		command.setContent(vo.getContent());
        iCommandService.save(command);
        return ResultConstant.Success;
    }	
    
	/**
	 * 查询命令
	 */
	@RequestMapping(value="/getById",method=RequestMethod.GET)
    @ResponseBody
    public Command getById(@RequestParam("id") Integer id) throws Exception { 
        Command command = iCommandService.getById(id);
		return command;
    }
	
	/**
	 * 删除命令
	 */
	@RequestMapping(value="/remove/{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Result remove(@PathVariable("id") Integer id) throws Exception { 
		iCommandService.delete(id);
		return ResultConstant.Success;
	}
	
	/**
	 * 查询所有
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getAll", method = RequestMethod.GET)
	@ResponseBody
	public List<Command> getAll() throws Exception {
		List<Command> all = iCommandService.getAll();
		Collections.sort(all, new Comparator<Command>() {
			@Override
			public int compare(Command o1, Command o2) {
				return (o1.getCategory_name()+o1.getTitle()).compareTo(o2.getCategory_name()+o2.getTitle());
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
