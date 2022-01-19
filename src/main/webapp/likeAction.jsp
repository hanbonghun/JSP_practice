<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="likey.LikeyDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%!public static String getClientIP(HttpServletRequest request) { //사이트에 접속한 사용자의 IP 알아내는 함수 
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("Proxy-Client-IP");

		}
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("WL-Proxy-Client-IP");

		}
		if (ip == null || ip.length() == 0) {
			ip = request.getRemoteAddr();

		}
		return ip;
	}%>



<% 
UserDAO userDAO = new UserDAO();
String userID = null;
if (session.getAttribute("userID") != null) { //사용자가 로그인한 상태(세션 o)
	userID = (String) session.getAttribute("userID");
} else {
	PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
	script.println("<script>");
	script.println("alert('로그인을 해주세요');");
	script.println("location.href='userLogin.jsp'");
	script.println("</script>");
	script.close();
	return;
}

request.setCharacterEncoding("utf-8");
String evaluationID = null;

if (request.getParameter("evaluationID") != null) {
	evaluationID = request.getParameter("evaluationID");
}
EvaluationDAO evaluationDAO = new EvaluationDAO();
LikeyDAO likeyDAO = new LikeyDAO();
int result = likeyDAO.like(userID, evaluationID, getClientIP(request));

if (result == 1) {//성공
	result = evaluationDAO.like(evaluationID);
	if (result == 1) {
		PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
		script.println("<script>");
		script.println("alert('추천하였습니다.');");
		script.println("location.href='./index.jsp'");
		script.println("</script>");
		script.close();
		return ;
	} else {
		PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}

} else {  // 특정 사용자가 이미 추천을 눌렀을 때 
	PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
	script.println("<script>");
	script.println("alert('이미 추천을 누른 글입니다.');");
	script.println("history.back()");
	script.println("</script>");
	script.close();
	
}
%>
