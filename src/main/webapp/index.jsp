<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder" %>


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


	<section class="container">
		<form class="form-inline mt-3" method="get" action="./index.jsp">
			<select name="lectureDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="전공">전공</option>
				<option value="교양">교양</option>
				<option value="기타">기타</option>
			</select> <select name="searchType" class="form-control mx-1 mt-2">
				<option value="최신순">최신순</option>
				<option value="추천순">추천순</option>

			</select> <input class="form-control mx-1 mt-2" type="text" name="search"
				placeholder="내용 입력">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>

			<%
			request.setCharacterEncoding("utf-8"); //데이터를(한글 포함) utf-8로 엔코딩하여 처리한다.
			String lectureDivide = "전체";
			String searchType = "최신순";
			String search = "";
			int pageNumber = 0;
			if (request.getParameter("lectureDivide") != null) {
				lectureDivide = request.getParameter("lectureDivide");

			}

			if (request.getParameter("searchType") != null) {
				searchType = request.getParameter("searchType");

			}

			if (request.getParameter("search") != null) {
				search = request.getParameter("search");

			}

			if (request.getParameter("pageNumber") != null) {
				try {
					pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
				} catch (Exception e) {
				}

			}

			UserDAO userDAO = new UserDAO();
			String userID = null;

			if (session.getAttribute("userID") != null) {
				userID = (String) session.getAttribute("userID");
			}

			if (userID != null && userDAO.getUserEmailChecked(userID) == true) {
			%>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal"
				href="#registerModal">등록하기</a> <a class="btn btn-danger mx-1 mt-2"
				data-toggle="modal" href="#reportModal">신고하기</a>
			<%
			}

			if (userID != null && (userDAO.getUserEmailChecked(userID) == false)) {
			%>
			<a class="btn btn-primary mx-1 mt-2" href="emailSendConfirm.jsp">등록하기</a>
			<a class="btn btn-danger mx-1 mt-2" href="emailSendConfirm.jsp">신고하기</a>
			<%
			}

			if (userID == null) {
			%>

			<a class="btn btn-primary mx-1 mt-2" href="userLogin.jsp">등록하기</a> <a
				class="btn btn-danger mx-1 mt-2" href="userLogin.jsp">신고하기</a>
			<%
			}
			%>

		</form>
		<%
		ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
		evaluationList = new EvaluationDAO().getList(lectureDivide, search, searchType, pageNumber);
		if (evaluationList != null) {
			for (int i = 0; i < evaluationList.size(); i++) {
				if (i == 5)
			break;
				EvaluationDTO evaluation = evaluationList.get(i);
		%>
		<div class="card  bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">
						<h6>
							<%=evaluation.getLectureName()%>
							<small><%=evaluation.getProfessorName()%></small>
						</h6>
					</div>
					<div class="col-4 text-right">
						종합 <span style="color: red;"> <%=evaluation.getTotalScore()%>
						</span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					<%=evaluation.getEvaluationTitle()%>
					<small>(<%=evaluation.getSemesterDivide()%>)
					</small>
				</h5>
				<p style="font-size: 15px;" class="card-text">
					<%
					evaluation.getEvaluationContent();
					%>
				</p>
				<div class="row">
					<div class="col-9 text-left">
						과제 <span style="color: red"><%=evaluation.getAssignment()%></span>
						조모임 <span style="color: red"><%=evaluation.getGroupMeeting()%></span>
						출결 <span style="color: red"><%=evaluation.getAttendance()%></span>
						<span style="color: green">(추천 : <%=evaluation.getLikeCount()%>)
						</span>

					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('추천하시겠습니까?')"
							href="./likeAction.jsp?evaluationID=">추천</a> <a
							onclick="return confirm('삭제하시겠습니까?')"
							href="./deleteAction.jsp?evaluationID=">삭제</a>
					</div>
				</div>
			</div>
		</div>

		<%
		}
		}
		%>


		<nav aria-label="..." class="d-flex justify-content-center mt-5">
			<ul class="pagination">
				<li class="page-item 
				<%if (pageNumber==0) {%> disabled <%} %>"> 
				<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide,"utf-8")%>&searchType=<%=URLEncoder.encode(searchType,"utf-8")%>&search=<%=URLEncoder.encode(search,"utf-8")%>&pageNumber=<%=pageNumber-1 %>">
					이전</a></li>
				<%
				int numberOfPosts = evaluationList.size();
				int pages = numberOfPosts / 5;
				%>
			

				<li class="page-item <%if (evaluationList.size()<6) {%> disabled <%} %> "><a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide,"utf-8")%>&searchType=<%=URLEncoder.encode(searchType,"utf-8")%>&search=<%=URLEncoder.encode(search,"utf-8")%>&pageNumber=<%=pageNumber+1 %>">다음</a></li>
			</ul>
		</nav>
	</section>





	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="registerModalLabel">평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<!-- 닫기버튼 -->
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<div>
									<label>강의명</label> <input type="text" name="lectureName"
										class="form-control">
								</div>
							</div>

							<div class="form-group col-sm-6">
								<label>교수명</label> <input type="text" name="professorName"
									class="form-control">
							</div>

							<div class="form-group col-md-4">
								<label>연도</label> <select name="lectureYear"
									class="form-control">
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
									<option value="2021">2021</option>
									<option value="2022">2022</option>
								</select>
							</div>
							<div class="form-group col-md-4">
								<label>수강학기</label> <select name="semesterDivide"
									class="form-control">
									<option value="1학기">1학기</option>
									<option value="여름학기">여름학기</option>
									<option value="2학기">2학기</option>
									<option value="겨울학기">겨울학기</option>
								</select>
							</div>
							<div class="form-group col-md-4">
								<label>구분</label> <select name="lectureDivide"
									class="form-control">
									<option value="전공">전공</option>
									<option value="교양">교양</option>
									<option value="기타">기타</option>
								</select>
							</div>
							<div class="form-group col-md-12">
								<label>제목</label> <input type="text" name="evaluationTitle"
									class="form-control">
							</div>
							<div class="form-group col-md-12">
								<label>내용</label>
								<textarea name="evaluationContent" class="form-control"
									style="height: 180px;"></textarea>
							</div>
							<div class="form-group col-md-2">
								<label>종합</label> <select name="totalScore" class="form-control">
									<option value="A">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">E</option>
								</select>
							</div>
							<div class="form-group col-md-3">
								<label>과제</label> <select name="assignment" class="form-control">
									<option value="많음">많음</option>
									<option value="보통">보통</option>
									<option value="적음">적음</option>
									<option value="없음">없음</option>

								</select>
							</div>
							<div class="form-group col-md-3">
								<label>조모임</label> <select name="groupMeeting"
									class="form-control">
									<option value="있음">있음</option>
									<option value="없음">없음</option>
								</select>
							</div>
							<div class="form-group col-md-4">
								<label>출결</label> <select name="attendance" class="form-control">
									<option value="전자출결">전자출결</option>
									<option value="직접호명">직접호명</option>
									<option value="없음">없음</option>
								</select>
							</div>
						</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
					<button type="submit" class="btn btn-primary">저장</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="registerModalLabel">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<!-- 닫기버튼 -->
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-md-12">
								<label>제목</label> <input type="text" name="reportTitle"
									class="form-control">
							</div>
							<div class="form-group col-md-12">
								<label>신고 내용</label>
								<textarea name="reportContent" class="form-control"
									style="height: 180px;"></textarea>
							</div>
						</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
					<button type="submit" class="btn btn-danger">신고하기</button>
				</div>
				</form>

			</div>
		</div>
	</div>

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