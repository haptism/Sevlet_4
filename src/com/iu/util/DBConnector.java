package com.iu.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBConnector {
	//Connection
	
	//메서드명은 getConnect
	//DB 연결객체를 리턴(Connection)
	//클래스 메서드로 생성
	public static Connection getConnect() throws Exception {
		String user = "user03";
		String password = "user03";
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
		String driver = "oracle.jdbc.driver.OracleDriver";
		
		//2. driver 메모리에 로딩
		Class.forName(driver);
		
		//3. 로그인 Connection
		Connection con = DriverManager.getConnection(url, user, password);
		
		return con;
	}
	
	//연결 끊기
	//메서드명 disConnect 매개변수 
	//클래스 메서드 
	
	public static void disConnect(ResultSet rs, PreparedStatement st, Connection con) throws Exception {
		rs.close();
		st.close();
		con.close();
	}
	public static void disConnect(PreparedStatement st, Connection con) throws Exception {
		st.close();
		con.close();
	}
	public static void disConnect(Connection con) throws Exception {
		con.close();
	}
	

}
