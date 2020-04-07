package com.my.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.all.util.util.MyStringUtil;

import lombok.Data;

@Data
public class Database {

	@SuppressWarnings("all")
	public static void main(String[] args) throws Exception {
		Map<String, Object> map = new TreeMap<String, Object>();
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/dzjt_pre_clear", "root", "root");
		if (conn != null) {
			System.out.println("数据库连接成功");
		}
		String sql = "select table_name from information_schema.tables where table_schema = 'dzjt_pre_clear' ";
		Statement statement = conn.createStatement();
		ResultSet result = statement.executeQuery(sql);
		ResultSet resultSet2 = null;
		while (result.next()) {
			try {
				//
				JSONObject jsonObject = new JSONObject();
				List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
				List<String> columns = new ArrayList<String>();
				List<String> camels = new ArrayList<String>();
				List<String> comments = new ArrayList<String>();
				String tableName = result.getString("TABLE_NAME");
				// 查询这个表的所有列
				String string = "select COLUMN_NAME,COLUMN_COMMENT from information_schema.`COLUMNS` where TABLE_SCHEMA = 'dzjt_pre_clear' and TABLE_NAME = '"+tableName.toLowerCase()+"'";
				statement = conn.createStatement();
				resultSet2 = statement.executeQuery(string);
				while(resultSet2.next()) {
					Map<String,String> m = new HashMap<String,String>();
					m.put(resultSet2.getString(1), resultSet2.getString(2));
					mapList.add(m);
				}
				Collections.sort(mapList, new Comparator<Map<String,String>>() {
					@Override
					public int compare(Map<String, String> o1, Map<String, String> o2) {
						String column1 = o1.keySet().iterator().next();
						String column2 = o2.keySet().iterator().next();
						return column1.compareTo(column2);
					}
				});
				for (Map<String, String> m : mapList) {
					Entry<String, String> next = m.entrySet().iterator().next();
					columns.add(next.getKey().toLowerCase());
					camels.add(MyStringUtil.column2Camel(next.getKey().toLowerCase()));
					comments.add(next.getValue());
				}
				jsonObject.put("columns", columns);
				jsonObject.put("camels", camels);
				jsonObject.put("comments", comments);
				map.put(tableName, jsonObject);
			} catch (Exception e) {
			}
		}
		String jsonString = JSON.toJSONString(map);
		System.err.println(jsonString);
	}

}
