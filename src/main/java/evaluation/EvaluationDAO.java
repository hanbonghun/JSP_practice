package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
			pstmt.setString(1, evalutionDTO.getUserID()); // ? 내용 채우는 항목 1
			pstmt.setString(2, evalutionDTO.getLectureName());
			pstmt.setString(3, evalutionDTO.getProfessorName());
			pstmt.setInt(4, evalutionDTO.getLectureYear());
			pstmt.setString(5, evalutionDTO.getSemesterDivide());
			pstmt.setString(6, evalutionDTO.getLectureDivide());
			pstmt.setString(7, evalutionDTO.getEvaluationTitle());
			pstmt.setString(8, evalutionDTO.getEvaluationContent());
			pstmt.setString(9, evalutionDTO.getTotalScore());
			pstmt.setString(10, evalutionDTO.getAssignment());
			pstmt.setString(11, evalutionDTO.getGroupMeeting());
			pstmt.setString(12, evalutionDTO.getAttendance());

			return pstmt.executeUpdate(); // 데이터베이스 갱신 후 개수 반환, 성공 -> 1

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn, rs, pstmt);
			// 데이터 베이스에 접근한 후 자원 해제
		}
		return -1; // 데이터베이스 오류
	}

}
