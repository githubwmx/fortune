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

import com.alibaba.fastjson.JSONObject;
import com.my.api.IArticleService;
import com.my.entity.Article;
import com.my.util.Result;
import com.my.util.ResultConstant;

/**
 * 文章Controller
 */
@Controller
@RequestMapping("/article")
public class ArticleController extends BaseController{
	
	private Logger logger = LoggerFactory.getLogger(ArticleController.class);

	@Resource
	private IArticleService iArticleService;
	
	/**
	 * 新增文章
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
    @ResponseBody
    public Result save(@RequestBody Article article) throws Exception {
        iArticleService.save(article);
        return ResultConstant.Success;
    }	
	
	/**
	 * 修改文章
	 */
	@RequestMapping(value="/update",method=RequestMethod.PUT)
    @ResponseBody
    public Result update(@RequestBody Article vo) throws Exception {
		// 更新文章
		Article article = iArticleService.getById(vo.getId());
		article.setCategory_name(vo.getCategory_name());
		article.setLabel(vo.getLabel());
		article.setTitle(vo.getTitle());
		article.setOptimization(vo.getOptimization());
		article.setContent(vo.getContent());
        iArticleService.save(article);
        return ResultConstant.Success;
    }	
    
	/**
	 * 查询文章
	 */
	@RequestMapping(value="/getById",method=RequestMethod.GET)
    @ResponseBody
    public Article getById(@RequestParam("id") Integer id) throws Exception { 
        Article article = iArticleService.getById(id);
        int count = article.getCount();
        count++;
        article.setCount(count);
        iArticleService.update(article);
		return article;
    }
	
	/**
	 * 随机生成复习题
	 */
	@RequestMapping(value="/getReview",method=RequestMethod.GET)
    @ResponseBody
    public JSONObject getReview(@RequestParam("number") Integer number) throws Exception { 
        List<Article> list = iArticleService.getByRandom(number);
        long count = iArticleService.getReviewCount();
        JSONObject result = new JSONObject();
        result.put("list", list);
        result.put("count", count);
		return result;
    }	
	
	/**
	 * 模糊搜索
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/search",method=RequestMethod.GET)
	@ResponseBody
	public List<Article> getById(@RequestParam("keyword") String keyword) throws Exception { 
		List<Article> list= iArticleService.getByKeyword(keyword);
		return list;
	}
	
	@RequestMapping(value="/getByCategory",method=RequestMethod.GET)
    @ResponseBody
    public List<Article> getByCategory(@RequestParam("name") String name) throws Exception { 
        return iArticleService.getByCategory(name);
    }
	
	/**
	 * 查询文章
	 */
	@RequestMapping(value="/getAllTitle",method=RequestMethod.GET)
	@ResponseBody
	public List<Article> getById() throws Exception { 
		return iArticleService.getAllTitle();
	}
	
	@RequestMapping(value="/getAllCategory",method=RequestMethod.GET)
	@ResponseBody
	public List<Object[]> getAllCategory() throws Exception {
		List<Object[]> allCategory = iArticleService.getAllCategory();
		return allCategory;
	}
	
	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}
	
}
