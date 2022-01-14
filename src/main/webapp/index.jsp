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

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="#">강의평가 웹 사이트</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="index.jsp">메인 <span class="sr-only">(current)</span></a></li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> 회원 관리 </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">로그인</a> <a class="dropdown-item"
							href="#">회원가입</a> <a class="dropdown-item" href="#">로그아웃</a>
					</div></li>
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>
	<section class="container">
		<!-- 본문 -->
		<form class="form-inline mt-3" method="get" action="./index.jsp">
			<select name="lectureDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="전공">전공</option>
				<option value="교양">교양</option>
				<option value="기타">기타</option>
			</select> <input class="form-control mx-1 mt-2" type="text" name="search"
				placeholder="내용 입력">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal"
				href="#registerModal">등록하기</a> <a class="btn btn-danger mx-1 mt-2"
				data-toggle="modal" href="#reportModal">신고하기</a>
		</form>
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
									<label>강의명</label> <input type="text" name="LectureName"
										class="form-control">
								</div>
							</div>

							<div class="form-group col-sm-6">
								<label>교수명</label> <input type="text" name="professorName"
									class="form-control">
							</div>

							<div class="form-group col-md-4">
								<label>연도</label> 
								<select name="LectureYear" class="form-control">
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
								<label>수강학기</label> 
								<select name="LectureYear" class="form-control">
									<option value="1학기">1학기</option>
									<option value="여름학기">여름학기</option>
									<option value="2학기">2학기</option>
									<option value="겨울학기">겨울학기</option>
								</select>
							</div>
							<div class="form-group col-md-4">
								<label>수강학기</label> 
								<select name="LectureDivide" class="form-control">
									<option value="1학기">전공</option>
									<option value="여름학기">교양</option>
									<option value="2학기">기타</option>
								</select>
							</div>
							<div class="form-group col-md-12">
								<label>제목</label>
								<input type="text" name="evaluationTitle" class="form-control">
							</div>
							<div class="form-group col-md-12">
								<label>내용</label>
								<textarea name="evaluationContent" class="form-control" style="height:180px;"></textarea>
							</div>
							<div class="form-group col-md-2">
								<label>종합</label> 
								<select name="LectureDivide" class="form-control">
									<option value="A">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">E</option>
								</select>
							</div>
							<div class="form-group col-md-3">
								<label>과제</label> 
								<select name="LectureDivide" class="form-control">
									<option value="많음">많음</option>
									<option value="보통">보통</option>
									<option value="적음">적음</option>
									<option value="없음">없음</option>
									
								</select>
							</div>
							<div class="form-group col-md-3">
								<label>조모임</label> 
								<select name="LectureDivide" class="form-control">
									<option value="있음">있음</option>
									<option value="없음">없음</option>
								</select>
							</div>
							<div class="form-group col-md-4">
								<label>출결</label> 
								<select name="LectureDivide" class="form-control">
									<option value="전자출결">전자출결</option>
									<option value="직접호명">직접호명</option>
									<option value="없음">없음</option>
								</select>
							</div>
						</div>


					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
					<button type="submit" class="btn btn-primary">저장</button>
				</div>
			</div>
		</div>
	</div>



	<form action="userJoinAction.jsp" method="post">
		<input type="text" name="userID"> <input type="password"
			name="userPassword"> <input type="submit" value="회원가입">
	</form>

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