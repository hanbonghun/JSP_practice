<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
if (session.getAttribute("userID") == null) { 
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.');");
	script.println("location.href= 'userLogin.jsp'");
	script.println("</script>");
}



	session.invalidate(); //세션 삭제
%>

<script>
	location.href="index.jsp";
</script>