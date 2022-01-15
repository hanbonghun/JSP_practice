<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import ="java.io.PrintWriter" %>

<% 
	request.setCharacterEncoding("utf-8");  //데이터를(한글 포함) utf-8로 엔코딩하여 처리한다.
	String userID = null;
	String code = null;
	UserDAO userDAO = new UserDAO();
	
	String userPassword = null;
	String userEmail = null;
	
	if (request.getParameter("code")!=null){ //사용자가 로그인 한 상태 
		code = request.getParameter("code");
	}
	
	
	if (session.getAttribute("userID")!=null){ //사용자가 로그인 한 상태 
		userID= (String) session.getAttribute("userID");
	}else{
		PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href='login.jsp'"); //이전 페이지로 이동 
		script.println("</script>");
		script.close();
		return ;
	}
	userEmail = userDAO.getUserEmail(userID);
	boolean isRight = SHA256.encrypt(userEmail).equals(code)? true: false; //사용자가 보낸 code값과 데이터베이스에 저장된 해쉬값 비교 

	if (isRight ==true ){ //일치 
		userDAO.setUserEmailChecked(userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('인증에 성공했습니다.');");
		script.println("location.href='index.jsp'"); //이전 페이지로 이동 
		script.println("</script>");
		script.close();
		return ;
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 코드입니다.');");
		script.println("location.href='index.jsp'"); //이전 페이지로 이동 
		script.println("</script>");
		script.close();
		return ;
	}
%>