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
	

	<section class="container">
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


		<div class="card  bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">
						강의명 <small>교수명</small>
					</div>
					<div class="col-4 text-right">
						종합<span style="color:red;"> A</span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					좋은 강의 <small>(2017년 가을학기)<small>
				</h5>	
				    <p style ="font-size: 15px;"class="card-text">강의가 널널, 솔직히 배운 건 없음</p>
				<div class="row">
					<div class="col-9 text-left">
						과제 <span style="color:red">보통</span>
						조모임 <span style="color:red">없음</span>
						출결 <span style="color:red">전자출결</span>
						<span style="color:green">(추천 : 15)</span>
						
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
						<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
					</div>
				</div>
			</div>
		</div>
		<div class="card  bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">
						강의명 <small>교수명</small>
					</div>
					<div class="col-4 text-right">
						종합<span style="color:red;"> A</span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					좋은 강의 <small>(2017년 가을학기)<small>
				</h5>	
				    <p style ="font-size: 15px;"class="card-text">강의가 널널, 솔직히 배운 건 없음</p>
				<div class="row">
					<div class="col-9 text-left">
						과제 <span style="color:red">보통</span>
						조모임 <span style="color:red">없음</span>
						출결 <span style="color:red">전자출결</span>
						<span style="color:green">(추천 : 15)</span>
						
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
						<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
					</div>
				</div>
			</div>
		</div>
				<div class="card  bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">
						강의명 <small>교수명</small>
					</div>
					<div class="col-4 text-right">
						종합<span style="color:red;"> A</span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					좋은 강의 <small>(2017년 가을학기)<small>
				</h5>	
				    <p style ="font-size: 15px;"class="card-text">강의가 널널, 솔직히 배운 건 없음</p>
				<div class="row">
					<div class="col-9 text-left">
						과제 <span style="color:red">보통</span>
						조모임 <span style="color:red">없음</span>
						출결 <span style="color:red">전자출결</span>
						<span style="color:green">(추천 : 15)</span>
						
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
						<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
					</div>
				</div>
			</div>
		</div>
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
								<label>연도</label> <select name="LectureYear"
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
								<label>수강학기</label> <select name="LectureYear"
									class="form-control">
									<option value="1학기">1학기</option>
									<option value="여름학기">여름학기</option>
									<option value="2학기">2학기</option>
									<option value="겨울학기">겨울학기</option>
								</select>
							</div>
							<div class="form-group col-md-4">
								<label>수강학기</label> <select name="LectureDivide"
									class="form-control">
									<option value="1학기">전공</option>
									<option value="여름학기">교양</option>
									<option value="2학기">기타</option>
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
								<label>종합</label> <select name="LectureDivide"
									class="form-control">
									<option value="A">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">E</option>
								</select>
							</div>
							<div class="form-group col-md-3">
								<label>과제</label> <select name="LectureDivide"
									class="form-control">
									<option value="많음">많음</option>
									<option value="보통">보통</option>
									<option value="적음">적음</option>
									<option value="없음">없음</option>

								</select>
							</div>
							<div class="form-group col-md-3">
								<label>조모임</label> <select name="LectureDivide"
									class="form-control">
									<option value="있음">있음</option>
									<option value="없음">없음</option>
								</select>
							</div>
							<div class="form-group col-md-4">
								<label>출결</label> <select name="LectureDivide"
									class="form-control">
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


					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
					<button type="submit" class="btn btn-danger">신고하기</button>
				</div>
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