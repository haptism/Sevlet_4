package com.iu.json;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.iu.board.BoardDTO;
import com.iu.board.comments.CommentsDAO;
import com.iu.board.comments.CommentsDTO;
import com.iu.board.notice.NoticeDAO;
import com.iu.page.SearchMakePage;
import com.iu.page.SearchRow;
import com.iu.util.DBConnector;

public class JsonService {


	public void test2(HttpServletRequest request, HttpServletResponse response){
		CommentsDAO commentsDAO = new CommentsDAO();
		int num = Integer.parseInt(request.getParameter("num"));
		SearchMakePage s = new SearchMakePage(1, "", "");
		SearchRow searchRow = s.makeRow();
		Connection con=null;
		List<CommentsDTO> ar = null;
		try {
			con = DBConnector.getConnect();
			ar = commentsDAO.selectList(searchRow, num, con);
			JSONArray jsonar = new JSONArray();//[]
			for(CommentsDTO commentsDTO:ar) {
				JSONObject jsonObject = new JSONObject();//{}
				jsonObject.put("writer", commentsDTO.getWriter());
				jsonObject.put("contents", commentsDTO.getContents());
				jsonar.add(jsonObject);
			}
			
			JSONObject js = new JSONObject();
			js.put("ar", jsonar);
			
			
			PrintWriter out = response.getWriter();
			out.println(js.toJSONString());
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	public void test1(HttpServletRequest request, HttpServletResponse response) {
		//this.test2(request, response);


		int num = Integer.parseInt(request.getParameter("num")); 
		NoticeDAO noticeDAO = new NoticeDAO(); 
		Connection con=null; 
		try { con = DBConnector.getConnect();
		BoardDTO boardDTO = noticeDAO.selectOne(num, con); 
		JSONObject jsonObject = new JSONObject();// {}
		System.out.println(boardDTO);
		jsonObject.put("writer", boardDTO.getWriter());//{"writer":"test"}
		jsonObject.put("contents", boardDTO.getContents());//{"writer":"test", "contents":"c"}
		jsonObject.put("title", boardDTO.getTitle());

		PrintWriter out = response.getWriter();
		out.println(jsonObject.toJSONString());	

		} catch (Exception e) { // TODO Auto-generated catch block
			e.printStackTrace(); }finally { try { con.close(); } catch (SQLException e) {
				// TODO Auto-generated catch block e.printStackTrace(); 
		} }



	}
}


