<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>


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
String reportTitle = null;
String reportContent = null;
if (request.getParameter("reportTitle")!=null){
	reportTitle = request.getParameter("reportTitle");
	
}
if (request.getParameter("reportContent")!=null){
	reportContent = request.getParameter("reportContent");
	
}

if(reportTitle ==null || reportContent ==null)
{
	PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
	script.println("<script>");
	script.println("alert('입력되지 않은 항목이 있습니다.');");
	script.println("history.back()");
	script.println("</script>");
	script.close();
	return;
}


boolean emailChecked = userDAO.getUserEmailChecked(userID);
if (emailChecked == false) { //이메일 인증이 안된 상태 
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이메일 인증이 필요합니다.');");
	script.println("location.href='emailSendConfirm.jsp'"); //이전 페이지로 이동 
	script.println("</script>");
	script.close();
	return;
} else { //인증이 된 상태  
	final String from = "bng4535@khu.ac.kr";       //your email
	final String password = "gksqhdgns1";	       //email password
	final String host = "http://localhost:8080/Lecture%20Evaluation/";   //host
	String to = userDAO.getUserEmail(userID);
	String sub = "강의평가 사이트에서 접수된 신고 내용입니다.";
	String msg = "신고자 : " +userID + "<br>제목: " + reportTitle +"<br>내용 : " + reportContent;

	Properties props = new Properties();
	props.put("mail.smtp.host", "smtp.gmail.com");
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.port", "465");
	props.put("mail.smtp.socketFactory.port", "465");
	props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	props.put("mail.smtp.ssl.protocols", "TLSv1.2");

	//get Session   
	Session mail_session = Session.getInstance(props, new javax.mail.Authenticator() {
		protected PasswordAuthentication getPasswordAuthentication() {
	return new PasswordAuthentication(from, password);
		}
	});
	//compose message    
	try {
		MimeMessage message = new MimeMessage(mail_session);
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		message.setSubject(sub);
		message.setText(msg, null, "html");
		//send message  
		Transport.send(message);
	} catch (MessagingException e) {
		throw new RuntimeException(e);
	}
}
%>

<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>강의평가 웹 사이트</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 반응형 처리 -->

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">


</head>



<body>
	<jsp:include page="./WEB-INF/views/header.jsp" />
	<section class="container mt-3" style="max-width: 560px;">
		<div class="alert alert-success mt-4" role="alert">신고 메일을 전송하였습니다.</div>
	</section>
	
	<jsp:include page="./WEB-INF/views/footer.jsp" />


	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>

</body>
</html>




