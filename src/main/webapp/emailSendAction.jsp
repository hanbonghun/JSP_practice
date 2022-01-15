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
	userID = (String)session.getAttribute("userID");
} else {
	PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
	script.println("<script>");
	script.println("alert('로그인을 해주세요');");
	script.println("location.href='userLogin.jsp'");
	script.println("</script>");
	script.close();
	return;
}

boolean emailChecked = userDAO.getUserEmailChecked(userID);
if (emailChecked == true) { //이메일 인증이 된 상태 
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 인증된 회원입니다.');");
	script.println("location.href='index.jsp'"); //이전 페이지로 이동 
	script.println("</script>");
	script.close();
	return;
} else { //인증이 되지 않은 상태 
	final String from = "bng4535@khu.ac.kr";
	final String password = "gksqhdgns1";
	final String host = "http://localhost:8080/Lecture%20Evaluation/";
	String to = userDAO.getUserEmail(userID);
	String sub = "강의평가를 위한 인증 메일";
	String msg = "다음 링크에 접속하여 메일 인증을 진행하세요."+ "<a href='"+ host+"emailCheckAction.jsp?code="+ SHA256.encrypt(to)+ "'> 이메일 인증하기</a>";

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
		message.setText(msg,null,"html");
		//send message  
		Transport.send(message);
	} catch (MessagingException e) {
		throw new RuntimeException(e);
	}
}
%>

	<jsp:include page="./userLogin.jsp" >
		<jsp:param name="action" value="afterSendMail" />
	</jsp:include>


