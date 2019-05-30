package com.iu.test.comments;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.SQLException;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.iu.board.comments.CommentsDAO;
import com.iu.board.comments.CommentsDTO;
import com.iu.util.DBConnector;

public class CommentsDAOTest {
	private CommentsDAO  commentsDAO;
	private Connection con;
	
	public CommentsDAOTest() {
		commentsDAO = new CommentsDAO();
	}
	
	@BeforeClass
	public static void start() {
		
	}
	
	@Before
	public void s() {
		try {
			con = DBConnector.getConnect();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void insertTest() throws Exception {
		CommentsDTO commentsDTO = new CommentsDTO();
		commentsDTO.setCnum(125);
		commentsDTO.setWriter("iu");
		commentsDTO.setContents("contents");
		int result=commentsDAO.insert(commentsDTO, con);
		assertEquals(1, result);
	}
	
	
	
	@After
	public void a() {
		try {
			
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@AfterClass
	public static void after() {}

}
