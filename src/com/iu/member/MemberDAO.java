package com.iu.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {
	
	public int idCheck(String id, Connection con)throws Exception{
		String sql ="select id from member where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, id);
		ResultSet rs = st.executeQuery();
		int check=1;
		if(rs.next()) {
			check=0;
		}
		rs.close();
		st.close();
		return check;
	}

}
