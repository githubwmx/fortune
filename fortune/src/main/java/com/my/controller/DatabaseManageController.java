package com.my.controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.all.util.util.MyStringUtil;
import com.my.util.MysqlUtil;

/**
 * 数据库管理Controller
 */
@Controller
@RequestMapping("/databaseManage")
public class DatabaseManageController extends BaseController {

	@RequestMapping(value = "/execQuery", method = RequestMethod.GET)
	@ResponseBody
	public List<String> execQuery(@RequestParam("sql") String sql) throws Exception {
		List<String> list = new ArrayList<String>();
		MysqlUtil mysqlUtil = new MysqlUtil("jdbc:mysql://127.0.0.1:3306/fortune", "root", "root");
		ResultSet select = mysqlUtil.select(sql);
		while(select.next()) {
			list.add(select.getString("id")+"");
			list.add(select.getString("category_name")+"");
			list.add(select.getString("createtime")+"");
			list.add(select.getString("is_delete")+"");
			list.add(select.getString("title")+"");
		}
		return list;
	}
	
	@RequestMapping(value = "/execQuery2", method = RequestMethod.GET)
	@ResponseBody
	public List<String> execQuery2(@RequestParam("sql") String sql) throws Exception {
		List<String> list = new ArrayList<String>();
		MysqlUtil mysqlUtil = new MysqlUtil("jdbc:mysql://127.0.0.1:3306/fortune", "root", "root");
		ResultSet select = mysqlUtil.select(sql);
		while(select.next()) {
			list.add(select.getString("id")+"");
			list.add(select.getString("name")+"");
		}
		return list;
	}
	
	/**
	 * 加载整个数据库的配置
	 */
	@RequestMapping(value = "/loadConfig", method = RequestMethod.GET)
	@ResponseBody
	public void loadConfig(@RequestParam("url") String url, @RequestParam("username") String username,
			@RequestParam("password") String password) throws Exception {
		String database = url.substring(url.lastIndexOf("/") + 1);
		// 加载模块
		MysqlUtil mysqlUtil = new MysqlUtil(url, username, password);
		String sql = String.format(" select distinct table_name from information_schema.`COLUMNS` where TABLE_SCHEMA = '%s' ", database); 
		ResultSet resultSet = mysqlUtil.select(sql);
		while(resultSet.next()) {
			String table_name = resultSet.getString("table_name").toLowerCase();
			String class_name = MyStringUtil.tableName2ClassName(table_name);
			String entity_name = MyStringUtil.lowerFirst(class_name);
			String table_comment = class_name;
			sql = String.format(" insert into module(table_name, table_comment, class_name, entity_name) values('%s','%s','%s','%s') ", table_name, table_comment, class_name, entity_name);
			int moduleId = mysqlUtil.executeInsert(sql);
			// 加载模块属性
			loadModuleColumns(mysqlUtil, database, table_name, moduleId);
		}
	}

	@SuppressWarnings("all")
	private void loadModuleColumns(MysqlUtil mysqlUtil,String database, String tableName,int moduleId) throws SQLException, Exception {
		String sql = String.format(" select column_name, column_comment, is_nullable, data_type, column_type from information_schema.`COLUMNS` where table_schema = '%s' and TABLE_NAME = '%s' ", database, tableName);
		ResultSet resultSet2 = mysqlUtil.select(sql);
		while(resultSet2.next()) {
			String column_name = resultSet2.getString("column_name");
			String column_comment = resultSet2.getString("column_comment");
			String is_nullable = resultSet2.getString("is_nullable"); 
			String data_type = resultSet2.getString("data_type");
			String column_type = resultSet2.getString("column_type");
			
			sql = String.format(" insert into module_column(column_, comment_, name, raw_type, module_id, nameUF) values('%s','%s','%s','%s','%d','%s') ", 
					column_name, 
					column_comment,
					MyStringUtil.column2Camel(column_name),
					data_type,
					moduleId,
					MyStringUtil.upperFirst(MyStringUtil.column2Camel(column_name))
				  );
			mysqlUtil.executeUpdate(sql);
		}
	}
	
}
