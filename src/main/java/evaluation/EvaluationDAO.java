package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {

	public void disconnect(Connection conn, ResultSet rs, PreparedStatement pstmt) { // db 연결 해제
		try {
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (rs != null)
				rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (pstmt != null)
				pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int write(EvaluationDTO evalutionDTO) { // 강의 평가 쓰기
		String SQL = "INSERT INTO EVALUATION VALUES(NULL, ?,?,?,?,?,?,?,?,?,?,?,?,0);";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
			pstmt.setString(1, evalutionDTO.getUserID().replaceAll("<", "&lt").replaceAll(">","&lt")); // ? 내용 채우는 항목 1
			pstmt.setString(2, evalutionDTO.getLectureName().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(3, evalutionDTO.getProfessorName().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setInt(4, evalutionDTO.getLectureYear());
			pstmt.setString(5, evalutionDTO.getSemesterDivide().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(6, evalutionDTO.getLectureDivide().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(7, evalutionDTO.getEvaluationTitle().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(8, evalutionDTO.getEvaluationContent().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(9, evalutionDTO.getTotalScore().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(10, evalutionDTO.getAssignment().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(11, evalutionDTO.getGroupMeeting().replaceAll("<", "&lt").replaceAll(">","&lt"));
			pstmt.setString(12, evalutionDTO.getAttendance().replaceAll("<", "&lt").replaceAll(">","&lt"));
			//.replaceAll("<", "&lt").replaceAll(">","&lt") : xxs(cross site scripting) 공격 방지 
			
			return pstmt.executeUpdate(); // 데이터베이스 갱신 후 개수 반환, 성공 -> 1

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn, rs, pstmt);
			// 데이터 베이스에 접근한 후 자원 해제
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<EvaluationDTO> getList (String lectureDivide, String search, String searchType, int pageNumber){
		if(lectureDivide.equals("전체")) {
			lectureDivide ="";
		}
		ArrayList<EvaluationDTO> evaluationList = null; //평가 글 목록 담는 배열 
			String SQL = "";
			ResultSet rs = null;
			Connection conn = null;
			PreparedStatement pstmt =null;
			try {
				if (searchType.equals("최신순")) {
					SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY  evaluationID DESC LIMIT " + pageNumber*5+","+ pageNumber*5+6 +";";
				}
				else if(searchType.equals("추천순")){
					SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY  likeCount DESC LIMIT " + pageNumber*5+","+ pageNumber*5 +6 +";";

					}
				conn = DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
				pstmt.setString(1, "%" + lectureDivide + "%"); 
				pstmt.setString(2, "%" + search + "%"); 
				rs = pstmt.executeQuery();
				evaluationList = new ArrayList<EvaluationDTO>();
				while(rs.next()) {
					EvaluationDTO evaluation = new EvaluationDTO(
							rs.getInt(1),
							rs.getString(2),
							rs.getString(3),
							rs.getString(4),
							rs.getInt(5),
							rs.getString(6),
							rs.getString(7),
							rs.getString(8),
							rs.getString(9),
							rs.getString(10),
							rs.getString(11),
							rs.getString(12),
							rs.getString(13),
							rs.getInt(14)
							);
					evaluationList.add(evaluation);
					
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				disconnect(conn,rs,pstmt);
				//데이터 베이스에 접근한 후 자원 해제 
			}
			return evaluationList; // 데이터베이스 오류
		
	}
	
	public int like(String evaluationID) { // 추천 눌렀을 떄 
		
		String SQL = "UPDATE EVALUATION SET likeCount = likeCount+1  WHERE  evaluationID = ?;";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
			pstmt.setInt(1, Integer.parseInt(evaluationID)); // ? 내용 채우는 항목 1
			return pstmt.executeUpdate();
			

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn,rs,pstmt);
		}
		return -1; // 데이터베이스 오류 
	}
	
public int delete(String evaluationID) { //  강의평가 글 삭제
		
		String SQL = "DELETE FROM EVALUATION  WHERE  evaluationID = ?;";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
			pstmt.setInt(1, Integer.parseInt(evaluationID)); // ? 내용 채우는 항목 1
			return pstmt.executeUpdate();
			

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn,rs,pstmt);
		}
		return -1; // 데이터베이스 오류 
	}


public String getUserID(String evaluationID) { // 강의평가 글을 작성한 사람의 ID를 가져오는 함수 
	
	String SQL = "SELECT userID FROM EVALUATION WHERE evaluationID = ?;";
	ResultSet rs = null;
	Connection conn = null;
	PreparedStatement pstmt =null;
	try {
		conn = DatabaseUtil.getConnection();
		pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
		pstmt.setInt(1, Integer.parseInt(evaluationID)); // ? 내용 채우는 항목 1
		rs = pstmt.executeQuery();
		if(rs.next()) { //결과 존재 
			return  rs.getString(1); // userEmailChecked 의 값 반환 
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		disconnect(conn,rs,pstmt);
	}
	return null; // 데이터베이스 오류 
}
}

