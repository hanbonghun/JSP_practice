<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="javax. %>

<% 

	UserDAO userDAO = new UserDAO(); 
	String userID = null;
	if (session.getAttribute("userID")!=null) { //사용자가 로그인한 상태(세션 o)
		userID = (String) session.getAttribute("userID");
	}else{
		PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
		script.println("<script>");
		script.println("alert('로그인을 해주세요');");
		script.println("location.href='userLogin.jsp'"); 
		script.println("</script>");
		script.close();
		return ;
	}


	boolean emailChecked =  userDAO.getUserEmailChecked(userID);
	if(emailChecked==true) { //이메일 인증이 된 상태 
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 인증된 회원입니다.');");
		script.println("location.href='index.jsp'"); //이전 페이지로 이동 
		script.println("</script>");
		script.close();
		return ;
	}else{ //인증이 되지 않은 상태 
		
		return ;
	}
	
	
%>