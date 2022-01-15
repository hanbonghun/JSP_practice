<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import ="java.io.PrintWriter" %>

<% 
	request.setCharacterEncoding("utf-8");  //데이터를(한글 포함) utf-8로 엔코딩하여 처리한다.
	String userID = null;
	String userPassword = null;
	
	if (request.getParameter("userID")!=null){
		userID= request.getParameter("userID");
	}
	if (request.getParameter("userPassword")!=null){
		userPassword= request.getParameter("userPassword");
	}
	
	if(userID == null || userPassword == null  || userID.equals("") ||  userPassword.equals("")){
		PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back()"); //이전 페이지로 이동 
		script.println("</script>");
		script.close();
		return ;
	}
	
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(userID, userPassword);
	if(result ==1) {  //로그인 성공
		session.setAttribute("userID", userID); //세션 생성 
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='index.jsp'"); //이전 페이지로 이동 
		script.println("</script>");
		script.close();
		return ;
	}else if (result == 0 ){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀렸습니다.');");
		script.println("history.back()"); //이메일 인증 
		script.println("</script>");
		script.close();
		return ;
	}else if(result ==-1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디가 존재하지 않습니다.');");
		script.println("history.back()"); //이메일 인증 
		script.println("</script>");
		script.close();
		return ;
	}else if(result ==-2){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터 베이스 오류.');");
		script.println("history.back()"); //이메일 인증 
		script.println("</script>");
		script.close();
		return ;
	}
%>