package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {

	public void disconnect(Connection conn, ResultSet rs, PreparedStatement pstmt) { // db ���� ����
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

	public int write(EvaluationDTO evalutionDTO) { // ���� �� ����
		String SQL = "INSERT INTO EVALUATION VALUES(NULL, ?,?,?,?,?,?,?,?,?,?,?,?,0);";
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);// sql���� �ߺ��ڵ� ���� ����
			pstmt.setString(1, evalutionDTO.getUserID()); // ? ���� ä��� �׸� 1
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

			return pstmt.executeUpdate(); // �����ͺ��̽� ���� �� ���� ��ȯ, ���� -> 1

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn, rs, pstmt);
			// ������ ���̽��� ������ �� �ڿ� ����
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public ArrayList<EvaluationDTO> getList (String lectureDivide, String search, String searchType, int pageNumber){
		if(lectureDivide.equals("��ü")) {
			lectureDivide ="";
		}
		ArrayList<EvaluationDTO> evaluationList = null; //�� �� ��� ��� �迭 
			String SQL = "";
			ResultSet rs = null;
			Connection conn = null;
			PreparedStatement pstmt =null;
			try {
				if (searchType.equals("�ֽż�")) {
					SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY  evaluationID DESC LIMIT " + pageNumber*5+","+ pageNumber*5+6 +";";
				}
				else if(searchType.equals("��õ��")){
					SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY  likeCount DESC LIMIT " + pageNumber*5+","+ pageNumber*5 +6 +";";

					}
				conn = DatabaseUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);// sql���� �ߺ��ڵ� ���� ����
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
				//������ ���̽��� ������ �� �ڿ� ���� 
			}
			return evaluationList; // �����ͺ��̽� ����
		
	}

}
