package com.iu.upload;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.iu.action.Action;
import com.iu.action.ActionForward;
import com.iu.util.DBConnector;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UploadService implements Action {
	private UploadDAO uploadDAO;
	
	public UploadService() {
		uploadDAO = new UploadDAO();
	}

	@Override
	public ActionForward list(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ActionForward select(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ActionForward insert(HttpServletRequest request, HttpServletResponse response) {
		// 스마트에디터 파일 업로드
		ActionForward actionForward = new ActionForward();
		int maxPostSize=50*1024*1024;
		String saveDirectory = request.getServletContext().getRealPath("upload_se2");
		System.out.println(saveDirectory);
		File file = new File(saveDirectory);
		if(!file.exists()) {
			file.mkdirs();
		}
		String result="";
		try {
			MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, maxPostSize, "UTF-8", new DefaultFileRenamePolicy());
			String callback = multipartRequest.getParameter("callback");
			String callback_func =multipartRequest.getParameter("callback_func");
			String fileName = multipartRequest.getFilesystemName("Filedata");
			
			//1. 절대 경로
			String path = request.getContextPath();
			//2. 최종 결과물
			result = "&bNewLine=true&sFileURL="+path+"/upload_se2/"+fileName;
			//3. 
			result=callback+"?callback_func="+callback_func+result;
			
			actionForward.setPath(result);
			actionForward.setCheck(false);
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return actionForward;
	}

	@Override
	public ActionForward update(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ActionForward delete(HttpServletRequest request, HttpServletResponse response) {
		ActionForward actionForward = new ActionForward();
		int result =0;
		Connection con=null;
		try {
			con = DBConnector.getConnect();
			int pnum= Integer.parseInt(request.getParameter("pnum"));
			result = uploadDAO.delete(pnum, con);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("result", result);
		actionForward.setCheck(true);
		actionForward.setPath("../WEB-INF/views/common/result2.jsp");
		return actionForward;
	}

}
