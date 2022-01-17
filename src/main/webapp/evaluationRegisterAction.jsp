<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
String userID= null; 
if (session.getAttribute("userID")!=null){
	 userID = (String)session.getAttribute("userID");
}
if (session.getAttribute("userID") == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인 해주세요. ');");
	script.println("location.href= 'userlogin.jsp'");
	script.println("</script>");
	script.close();
	return;
}

request.setCharacterEncoding("utf-8"); //데이터를(한글 포함) utf-8로 엔코딩하여 처리한다.

String lectureName=null;
String professorName=null;
int lectureYear=0;
String semesterDivide=null;
String lectureDivide=null;
String evaluationTitle=null;
String evaluationContent=null;
String totalScore=null;
String assignment=null;
String groupMeeting=null;
String attendance=null;

if (request.getParameter("lectureName") != null) {
	lectureName = request.getParameter("lectureName");
}
if (request.getParameter("professorName") != null) {
	professorName = request.getParameter("professorName");
}

if (request.getParameter("lectureYear") != null) {
	lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
}
if (request.getParameter("semesterDivide") != null) {
	semesterDivide = request.getParameter("semesterDivide");
}
if (request.getParameter("lectureDivide") != null) {
	lectureDivide = request.getParameter("lectureDivide");
}
if (request.getParameter("evaluationTitle") != null) {
	evaluationTitle = request.getParameter("evaluationTitle");
}
if (request.getParameter("evaluationContent") != null) {
	evaluationContent = request.getParameter("evaluationContent");
}
if (request.getParameter("totalScore") != null) {
	totalScore = request.getParameter("totalScore");
}
if (request.getParameter("assignment") != null) {
	assignment = request.getParameter("assignment");
}
if (request.getParameter("groupMeeting") != null) {
	groupMeeting = request.getParameter("groupMeeting");
}
if (request.getParameter("attendance") != null) {
	attendance = request.getParameter("attendance");
}

if (userID ==null ||lectureName==null||professorName==null|| lectureYear==0||semesterDivide==null || lectureDivide ==null || evaluationTitle ==null || lectureName.equals("")||evaluationContent==null|| totalScore ==null|| assignment==null||groupMeeting ==null ||attendance==null|| professorName.equals("")|| evaluationTitle.equals("")|| evaluationContent.equals("")) {
	PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
	script.println("<script>");
	script.println("alert('입력이 안 된 사항이 있습니다.');");
	script.println("history.back()"); //이전 페이지로 이동 
	script.println("</script>");
	script.close();
	return;
}

EvaluationDAO evaluationDAO = new EvaluationDAO();
int result = evaluationDAO.write(new EvaluationDTO(0,userID,lectureName,professorName,lectureYear,semesterDivide,lectureDivide,evaluationTitle,evaluationContent,totalScore,assignment,groupMeeting,attendance,0));
if (result == -1) { //강의평가 등록 실패 
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('강의 평가 등록에 실패했습니다.');");
	script.println("history.back()"); //이전 페이지로 이동 
	script.println("</script>");
	script.close();
	return;
} else {
	session.setAttribute("userID", userID); //세션 생성 
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('강의 평가를 등록하였습니다.');");
	script.println("location.href='index.jsp'"); //이메일 인증 
	script.println("</script>");
	script.close();
	return;
}
%>