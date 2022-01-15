<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import ="java.io.PrintWriter" %>

<% 
	request.setCharacterEncoding("utf-8");  //데이터를(한글 포함) utf-8로 엔코딩하여 처리한다.
	String userID = null;
	String userPassword = null;
	String userEmail = null;
	
	if (request.getParameter("userID")!=null){
		userID= request.getParameter("userID");
	}
	if (request.getParameter("userPassword")!=null){
		userPassword= request.getParameter("userPassword");
	}
	if (request.getParameter("userEmail")!=null){
		userEmail= request.getParameter("userEmail");
	}
	
	if(userID == null || userPassword == null || userEmail == null || userID.equals("") || userEmail.equals("") || userPassword.equals("")){
		PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back()"); //이전 페이지로 이동 
		script.println("</script>");
		script.close();
		return ;
	}
	
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.join(new UserDTO(userID,userPassword,userEmail,SHA256.encrypt(userEmail),false));
	if(result ==-1) {  //회원가입 실패 (아이디 중복)
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디 입니다.');");
		script.println("history.back()"); //이전 페이지로 이동 
		script.println("</script>");
		script.close();
		return ;
	}else{
		session.setAttribute("userID", userID); //세션 생성 
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='emailSendAction.jsp'"); //이메일 인증 
		script.println("</script>");
		script.close();
		return ;
	}
%>