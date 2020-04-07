package com.my.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.api.IFolderService;
import com.my.entity.Folder;
import com.my.util.Result;
import com.my.util.ResultConstant;

/**
 * 文件夹管理
 */
@Controller
@RequestMapping("/folder")
public class FolderController extends BaseController{

	@Autowired
	private IFolderService iFolderService;
	
	@RequestMapping(value="/save",method=RequestMethod.POST)
    @ResponseBody 
    public Result save(HttpServletRequest request, HttpServletResponse response, @RequestBody Folder folder) throws Exception {
		iFolderService.save(folder);
		return ResultConstant.createSuccessMessage("新增成功.");
	}

	@RequestMapping(value="/update",method=RequestMethod.PUT)
	@ResponseBody 
	public Result update(HttpServletRequest request, HttpServletResponse response, @RequestBody Folder folder) throws Exception {
		Folder dbFolder = iFolderService.getById(folder.getId());
		dbFolder.setName(folder.getName());
		dbFolder.setPath(folder.getPath());
		dbFolder.setCategory(folder.getCategory());
		iFolderService.update(dbFolder);
		return ResultConstant.createSuccessMessage("新增成功.");
	}
	
	@RequestMapping(value="/explore",method=RequestMethod.GET)
	@ResponseBody
	public void getAll(@RequestParam("id") Integer id ) throws Exception {
		Folder folder = iFolderService.getById(id);
		String path = folder.getPath();
		Runtime.getRuntime().exec("cmd /k explorer " + path);
	}
	
	@RequestMapping(value="/getAll",method=RequestMethod.GET)
	@ResponseBody
	public List<Folder> getAll() throws Exception { 
		List<Folder> all = iFolderService.getAll();
		Collections.sort(all, new Comparator<Folder>() {
			@Override
			public int compare(Folder o1, Folder o2) {
				return (o1.getCategory()+o1.getName()).compareTo(o2.getCategory()+o2.getName());
			}
		});
		return all;
	}
	
	@RequestMapping(value="/getById",method=RequestMethod.GET)
    @ResponseBody
    public Folder getById(@RequestParam("id") Integer id) throws Exception { 
        return iFolderService.getById(id);
    }
	
}
