package com.my.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.all.util.util.MyStringUtil;
import com.my.entity.Article;

/**
 * 字符串Controller
 */
@Controller
@RequestMapping("/string")
public class StringController extends BaseController{
	
//	@RequestMapping(value="/self",method=RequestMethod.POST)
//	@ResponseBody
//	public JSONObject self(@RequestBody Article article) throws Exception {
//		StringBuffer stringBuffer = new StringBuffer();
//		String[] split = article.getContent().split("\n");
//		for (String string : split) {
//			String[] words = string.split("\\s+");
//			stringBuffer.append(String.format("EXCEPTION_%s(%s, \"%s\"),\n", words[0], words[0], words[2]));
//		}
//		JSONObject jsonObject = new JSONObject();
//		jsonObject.put("result", stringBuffer);
//		return jsonObject;
//	}

	@RequestMapping(value="/columnAlias",method=RequestMethod.POST)
    @ResponseBody
    public JSONObject columnAlias(@RequestBody Article article) throws Exception {
		StringBuffer stringBuffer = new StringBuffer();
		String[] split = article.getContent().split("\n");
		for(int i=0;i<split.length;i++) {
			String string = split[i];
			String column = string.split(" ")[2];
			String columnRaw = column.substring(1, column.length()-1);
			String stringResult = MyStringUtil.column2Camel(columnRaw);
			stringBuffer.append(article.getTitle()+columnRaw + " " + stringResult);
			if(i != split.length-1) {
				stringBuffer.append(",");
			}
			stringBuffer.append("\n");
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", stringBuffer.toString());
        return jsonObject;
    }
	
//	@RequestMapping(value="/vo2Bean",method=RequestMethod.POST)
//	@ResponseBody
//	public JSONObject vo2Bean(@RequestBody Article article) throws Exception {
//		StringBuffer stringBuffer = new StringBuffer();
//		String title = article.getTitle();
//		String[] split = article.getContent().split("\n");
//		for (String string : split) {
//			String column = string.split(" ")[2].toLowerCase();
//			String columnRaw = column.substring(1, column.length()-1); // user_name
//			String camel = MyStringUtil.column2Camel(columnRaw); // userName
//			String camelUF = MyStringUtil.upperFirst(camel); // UserName;
//			stringBuffer.append(String.format("db%s.set%s(%s.get%s());\n", title, camelUF, MyStringUtil.lowerFirst(title), camelUF));
//		}
//		JSONObject jsonObject = new JSONObject();
//		jsonObject.put("result", stringBuffer);
//		return jsonObject;
//	}

}
