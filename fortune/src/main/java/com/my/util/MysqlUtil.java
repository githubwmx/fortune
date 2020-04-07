package com.my.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

//import com.mysql.jdbc.Statement;

public class MysqlUtil {
	
	private Connection connection = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	private String driver = "com.mysql.jdbc.Driver";
	private String url = null;
	private String username = null;
	private String password = null;

	public MysqlUtil(String url, String username,String password) {
		this.url = url;
		this.username = username;
		this.password = password;
	}
	
	private Connection getConnection() {
		try {
			if(connection != null) {
				return connection;
			} else {
				Class.forName(driver);
				connection = DriverManager.getConnection(url, username, password);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}

	public ResultSet select(String sql) {
		try {
			connection = getConnection();
			ps = connection.prepareStatement(sql);
			rs = ps.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public int executeInsert(String sql) throws Exception {
		try {
			connection = getConnection();
//			ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			@SuppressWarnings("unused")
			int affectedNum = ps.executeUpdate();
			ResultSet generatedKeys = ps.getGeneratedKeys();
			while(generatedKeys.next()) {
				return generatedKeys.getInt(1);
			}
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} finally {
		}
		return 0;
	}
	
	public int executeUpdate(String sql) throws Exception {
		int num = 0;
		try {
			connection = getConnection();
			ps = connection.prepareStatement(sql);
			num = ps.executeUpdate();
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} finally {
		}
		return num;
	}

	public int executeBatch(List<String> sqlList) {
		int result = 0;
		for (String sql : sqlList) {
			try {
				result += executeUpdate(sql);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	public void close() {
		try {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (connection != null) {
				connection.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
