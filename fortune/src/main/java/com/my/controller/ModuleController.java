package com.my.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.alibaba.fastjson.JSONObject;
import com.my.api.IModuleColumnService;
import com.my.api.IModuleService;
import com.my.entity.Module;
import com.my.entity.ModuleColumn;
import com.my.util.Result;
import com.my.util.ResultConstant;
import com.my.vo.Relation;

import freemarker.template.Configuration;

/**
 * 模块Controller
 */
@Controller
@RequestMapping("/module")
public class ModuleController extends BaseController {
	
	private Logger logger = LoggerFactory.getLogger(ModuleController.class);

	@Resource
	private IModuleService iModuleService;
	@Resource
	private IModuleColumnService iModuleColumnService;
	
//	@SuppressWarnings("all")
//	@RequestMapping(value="/vo2DB",method=RequestMethod.POST)
//	@ResponseBody
//	public JSONObject vo2DB(@RequestBody Relation relation) throws Exception {
//		String master = relation.getMaster();
//		Module module = iModuleService.getByTableName(master);
//		List<ModuleColumn> columns = module.getColumns();
//		StringBuffer stringBuffer = new StringBuffer();
//		for (ModuleColumn column : columns) {
//			stringBuffer.append(String.format("db%s.set%s(%s.get%s());\n", module.getClass_name(), column.getNameUF(), module.getEntity_name(), column.getNameUF()));
//		}
//		JSONObject jsonObject = new JSONObject();
//		jsonObject.put("result", stringBuffer.toString());
//		return jsonObject;
//	}
		
	/**
	 * 生成代码
	 */
	@SuppressWarnings("all")
	@RequestMapping(value="/generate",method=RequestMethod.POST)
	@ResponseBody
	public void generate(@RequestBody Relation relation) throws Exception {
		String master = relation.getMaster();
		String relations = relation.getRelations();
		String slaves = relation.getSlaves();
		String[] relationArray = relations.split(",");
		String[] slaveArray = slaves.split(",");
		Module masterModule = iModuleService.getByTableName(master);
		List<Module> slaveModules = new ArrayList<Module>();
		if(slaveArray!=null && !"".equals(slaveArray[0])) {
			for (int i = 0; i < slaveArray.length; i++) {
				String string = slaveArray[i];
				Module module = iModuleService.getByTableName(string);
				module.setRelation(relationArray[i]);
				slaveModules.add(module);
			}
		}
		//
		Configuration configuration = new Configuration();
		configuration.setDirectoryForTemplateLoading(new File("F:\\workspace.all\\fortune\\src\\main\\java\\com\\my\\controller\\ftl\\"));
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("module", masterModule);
		if(slaveModules.size()>0) {
			map.put("slaves", slaveModules);
		}
		configuration.getTemplate("EntityController.java.ftl").process(map, new OutputStreamWriter(new FileOutputStream(new File("C:\\Users\\24582\\Desktop\\"+masterModule.getClass_name()+"Controller.java"))));		
		configuration.getTemplate("EntityService.java.ftl").process(map, new OutputStreamWriter(new FileOutputStream(new File("C:\\Users\\24582\\Desktop\\"+masterModule.getClass_name()+"Service.java"))));		
		configuration.getTemplate("EntityServiceImpl.java.ftl").process(map, new OutputStreamWriter(new FileOutputStream(new File("C:\\Users\\24582\\Desktop\\"+masterModule.getClass_name()+"ServiceImpl.java"))));		
		configuration.getTemplate("EntityMapper.java.ftl").process(map, new OutputStreamWriter(new FileOutputStream(new File("C:\\Users\\24582\\Desktop\\"+masterModule.getClass_name()+"Mapper.java"))));		
		configuration.getTemplate("EntityMapper.xml.ftl").process(map, new OutputStreamWriter(new FileOutputStream(new File("C:\\Users\\24582\\Desktop\\"+masterModule.getClass_name()+"Mapper.xml"))));		
		configuration.getTemplate("AllMapper.xml.ftl").process(map, new OutputStreamWriter(new FileOutputStream(new File("C:\\Users\\24582\\Desktop\\AllMapper.xml"))));		
		configuration.getTemplate("ParamVo.java.ftl").process(map, new OutputStreamWriter(new FileOutputStream(new File("C:\\Users\\24582\\Desktop\\"+masterModule.getClass_name()+"ParamVo.java"))));		
		configuration.getTemplate("Bean.java.ftl").process(map, new OutputStreamWriter(new FileOutputStream(new File("C:\\Users\\24582\\Desktop\\"+"Bean.java"))));		
	}

	/**
	 * 修改模块
	 */
	@RequestMapping(value="/update",method=RequestMethod.PUT)
    @ResponseBody
    public Result update(@RequestBody Module vo) throws Exception {
		// 更新模块
		Module module = iModuleService.getById(vo.getId());
		module.setContent(vo.getContent());
        iModuleService.save(module);
        return ResultConstant.Success;
    }	
    
	/**
	 * 查询模块
	 */
	@RequestMapping(value="/getById",method=RequestMethod.GET)
    @ResponseBody
    public Module getById(@RequestParam("id") Integer id) throws Exception { 
        Module module = iModuleService.getById(id);
		return module;
    }
	
	/**
	 * 查询一个模拟的所有列
	 */
	@RequestMapping(value="/getColumnsById/{id}",method=RequestMethod.GET)
	@ResponseBody
	public List<ModuleColumn> getColumnsById(@PathVariable("id") Integer id) throws Exception { 
		List<ModuleColumn> columns = iModuleColumnService.getByModuleId(id);
		return columns;
	}
	
	/**
	 * 查询所有
	 */
	@RequestMapping(value="/getAll",method=RequestMethod.GET)
	@ResponseBody
	public List<Module> getAll() throws Exception { 
		List<Module> all = iModuleService.getAll();
		return all;
	}
	
	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}
	
}
