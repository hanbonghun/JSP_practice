<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 반응형 처리 -->

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">


</head>

<%
String userID = null;
if (session.getAttribute("userID") != null) { 
	userID = (String)session.getAttribute("userID");
}
if(userID !=null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 로그인 하였습니다.');");
	script.println("location.href= 'index.jsp'");
	script.println("</script>");
	script.close();
	return ;
}
%>

<body>
	<jsp:include page="./WEB-INF/views/header.jsp" />
	<section class="container mt-3" style="max-width: 560px;">
		<form method="post" action="./userRegisterAction.jsp">
			<div class="form-group">
				<label>아이디</label> <input type="text" name="userID"
					class="form-control" />
			</div>
			<div class="form-group">
				<label>비밀번호</label> <input type="password" name="userPassword"
					class="form-control" />
			</div>
			<div class="form-group">
				<label>이메일</label> <input type="text" name="userEmail"
					class="form-control" />
			</div>
			</div>
			<button type="submit" class="btn btn-primary">회원가입</button>
		</form>
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